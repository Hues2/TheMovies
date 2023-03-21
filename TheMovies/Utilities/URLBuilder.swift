//
//  URLBuilder.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


class URLBuilder {
    static let shared = URLBuilder()
    
    private init(){}
    
    func movieURL(_ publisher : APIDataInteractor.MotionPicturePublisher, _ page : Int) -> String {
        switch publisher {
        case .upcoming, .topRated, .popular:
            return "\(Constants.shared.baseURL)movie/\(publisher.rawValue)?api_key=\(Constants.shared.key)&language=en-US&page=\(page)"

        case .trending:
            return "\(Constants.shared.baseURL)\(publisher.rawValue)/movie/day?api_key=\(Constants.shared.key)"
            
        case .airingToday, .recommendations:
            return ""
        }
    }
    
    func tvURL(_ publisher : APIDataInteractor.MotionPicturePublisher, _ page : Int) -> String{
        switch publisher {
        case .popular, .topRated, .airingToday:
            return "\(Constants.shared.baseURL)tv/\(publisher.rawValue)?api_key=\(Constants.shared.key)&language=en-US&page=\(page)"
        case .trending:
            return "\(Constants.shared.baseURL)\(publisher.rawValue)/tv/day?api_key=\(Constants.shared.key)"
            
        case .upcoming, .recommendations:
            return ""
        }
    }
    
    
    func getRecommendationsURL(_ type : MotionPictureData.MotionPicture.MotionPictureType, _ id : Int, _ page : Int) -> String {
        return "https://api.themoviedb.org/3/\(type)/\(id)/recommendations?api_key=\(Constants.shared.key)&language=en-US&page=\(page))"
    }
    
}
