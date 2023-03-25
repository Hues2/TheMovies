//
//  AppPath.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation

enum AppPath : Hashable {
    case home
    case favourites
    case detail(MotionPictureData.MotionPicture)
}
