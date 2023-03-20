//
//  MotionPictureDetailView.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI
import URLImage

struct MotionPictureDetailView: View {
    
    @StateObject var detailVM : MotionPictureDetailViewModel
    
    init(_ motionPicture : MotionPictureData.MotionPicture) {
        self._detailVM = StateObject(wrappedValue: MotionPictureDetailViewModel(motionPicture))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                
                // Image Header
                imageHeader
                    .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.25)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Info Header
                infoHeader
                
            }
            .padding()
        }
    }
}



extension MotionPictureDetailView {
    
    @ViewBuilder
    private var imageHeader : some View {
        if let url = detailVM.motionPicture.backdropURL {
            URLImage(url) {
                loadingHeaderCard
                } inProgress: { progress in
                    loadingHeaderCard
                } failure: { error, retry in
                    loadingHeaderCard
                } content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
            }
        }
    
    private var loadingHeaderCard : some View {
        ZStack {
            Color.backgroundColor
                .cornerRadius(10)
                .shadow(radius: 5)
            
            ProgressView()
                .tint(Color.accentColor)
        }
        .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.25)
    }
    
    private var infoHeader : some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(detailVM.motionPicture.name ?? detailVM.motionPicture.title ?? "Unknown")")
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Text("\(detailVM.motionPicture.release_date ?? detailVM.motionPicture.first_air_date ?? "")")
                    .fontWeight(.thin)
                Spacer()
                RatingView(rating: detailVM.motionPicture.vote_average ?? 0.0, frameSize: 30)
                    .frame(width: 35, height: 35)
            }
            
            
            Divider()
            
            Text("\(detailVM.motionPicture.overview ?? "")")
            
        }
        .padding(.top, 15)
        
    }
}
