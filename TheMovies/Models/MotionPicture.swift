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
        let original_name: String?
        let original_title: String?
        let poster_path: String?
        let backdrop_path: String?
        let overview: String?
        let release_date: String?
        let first_air_date: String?
        let vote_average: Double?
        let vote_count: Int?
        var type: MotionPictureType { original_name != nil ? .tv : .movie }
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
