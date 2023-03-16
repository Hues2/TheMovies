//
//  MotionPictureDetailViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


class MotionPictureDetailViewModel : ObservableObject {
    
    let motionPicture : MotionPictureData.MotionPicture
    
    init(_ motionPicture : MotionPictureData.MotionPicture) {
        self.motionPicture = motionPicture
    }
    
}
