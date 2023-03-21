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
    
    init(_ motionPicture : MotionPictureData.MotionPicture, _ favouritesInteractor : FavouritesInteractor, _ apiDataInteractor : APIDataInteractor) {
        self._detailVM = StateObject(wrappedValue: MotionPictureDetailViewModel(motionPicture, favouritesInteractor, apiDataInteractor))
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
                    .padding(.top, 15)
                
                // Cast
                cast
                    .padding(.top, 25)

                
                // Recommendations
                if !detailVM.recommendedMotionPictures.isEmpty {
                    HorizontalScrollView(motionPictures: detailVM.recommendedMotionPictures, favouritesInteractor: detailVM.favouritesInteractor, title: "Recommendations")
                        .padding(.top, 25)
                }
                
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavouriteHeart(motionPicture: detailVM.motionPicture, favouritesInteractor: detailVM.favouritesInteractor, font: .title2, isInToolBar: true)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                            detailVM.alterFavourites()
                        }
                        HapticFeedback.shared.impact(.medium)
                    }
            }
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
    }
    
    private var cast : some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Cast")
                .font(.title2)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(detailVM.cast) { castMember in
                        castCard(castMember)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func castCard(_ castMember : CastData.Cast) -> some View {
        if let imageURL = castMember.imageURL {
            URLImage(imageURL) { image, info in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
        }
    }
    
    
    
}
