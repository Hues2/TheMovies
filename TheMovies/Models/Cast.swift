//
//  Cast.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import Foundation


struct CastData : Identifiable, Codable {
    let id : Int
    let cast : [Cast]
    
    struct Cast : Identifiable, Codable, Equatable {
        let id : Int?
        let name : String?
        let profilePath : String?
        let character : String?
        let creditID : String?
        var imageURL: URL? {
            guard let profilePath else { return nil }
            let url = URL(string: "\(Constants.shared.baseImageURL)\(profilePath)")
            guard let url else { return nil }
            return url
        }
        
        enum CodingKeys : String, CodingKey {
            case id, name, character
            case profilePath = "profile_path"
            case creditID = "credit_id"
        }
    }
}
