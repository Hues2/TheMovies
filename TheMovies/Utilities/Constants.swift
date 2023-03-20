//
//  Constants.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


class Constants {
    
    static let shared = Constants()
    
    private init() {}
    
    let key : String = ""
    let baseURL : String = "https://api.themoviedb.org/3/"
    let baseImageURL : String = "https://image.tmdb.org/t/p/w500/"
    let autoSwipeSeconds : Double = 10
    
}
