//
//  MotionPictureDetailView.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI

struct MotionPictureDetailView: View {
    
    @StateObject var motionPictureDetailVM : MotionPictureDetailViewModel
    
    init(_ motionPicture : MotionPictureData.MotionPicture) {
        self._motionPictureDetailVM = StateObject(wrappedValue: MotionPictureDetailViewModel(motionPicture))
    }
    
    var body: some View {
        Text("Motion Picture Detail View")
    }
}
