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
    
    let key = "b8670653a1b9591be26fa80174975862"
    let baseURL = "https://api.themoviedb.org/3/"
    let baseImageURL = "https://image.tmdb.org/t/p/w500/"    
    
}
