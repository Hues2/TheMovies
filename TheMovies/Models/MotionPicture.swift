//
//  MotionPicture.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


struct MotionPictureData : Codable {
    let page : Int?
    let results : [MotionPicture]?
    
    struct MotionPicture : Identifiable, Hashable, Codable {
        let id: Int?
        let genreIDS: [Int]?
        let name: String? // --> For tv
        let title: String? // --> For Movie
        let poster_path: String?
        let backdrop_path: String?
        let overview: String?
        let release_date: String? // --> For Movie
        let first_air_date: String? // --> For TV
        let vote_average: Double?
        let vote_count: Int?
        var type: MotionPictureType { name != nil ? .tv : .movie }
        var posterURL: URL? {
            guard let poster_path else { return nil }
            let url = URL(string: "\(Constants.shared.baseImageURL)\(poster_path)")
            guard let url else { return nil }
            return url
        }
        var backdropURL: URL? {
            guard let backdrop_path else { return nil }
            let url = URL(string: "\(Constants.shared.baseImageURL)\(backdrop_path)")
            guard let url else { return nil }
            return url
        }
        
        enum MotionPictureType {
            case movie, tv
        }

    }
}
