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
    
    func movieURL(_ type : APIDataInteractor.MotionPicturePublisher, _ page : Int) -> String {
        switch type {
        case .upcoming, .topRated, .popular:
            return "\(Constants.shared.baseURL)movie/\(type.rawValue)?api_key=\(Constants.shared.key)&language=en-US&page=\(page)"
            
        case .trending:
            return "\(Constants.shared.baseURL)\(type.rawValue)/movie/day?api_key=\(Constants.shared.key)"
            
        case .airingToday:
            return ""
        }
    }
    
    func tvURL(_ type : APIDataInteractor.MotionPicturePublisher, _ page : Int) -> String{
        switch type {
        case .popular, .topRated, .airingToday:
            return "\(Constants.shared.baseURL)tv/\(type.rawValue)?api_key=\(Constants.shared.key)&language=en-US&page=\(page)"
        case .trending:
            return "\(Constants.shared.baseURL)\(type.rawValue)/tv/day?api_key=\(Constants.shared.key)"
            
        case .upcoming:
            return ""
        }
    }
}
