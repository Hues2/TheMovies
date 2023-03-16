//
//  HomeNavigationInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


class HomeNavigationInteractor : ObservableObject {
    
    @Published var homePath = [HomePath]()
    
    
    enum HomePath : Hashable {
        case home
        case detail(MotionPictureData.MotionPicture)
    }
    
}
