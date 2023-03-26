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
    
    @Namespace private var namespace
    @State private var selectedCast : CastData.Cast? = nil
    
    init(_ motionPicture : MotionPictureData.MotionPicture, _ favouritesInteractor : FavouritesInteractor, _ apiDataInteractor : APIDataInteractor,
         _ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self._detailVM = StateObject(wrappedValue: MotionPictureDetailViewModel(motionPicture, favouritesInteractor, apiDataInteractor, authInteractor, appInteractor))
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
                    HorizontalScrollView(motionPictures: detailVM.recommendedMotionPictures, title: "Recommendations", favouritesInteractor: detailVM.favouritesInteractor, authInteractor: detailVM.authInteractor, appInteractor: detailVM.appInteractor)
                        .padding(.top, 25)
                }
                
            }
            .padding()
        }
        .onAppear{
            detailVM.getCast()
            detailVM.getRecommendations()
        }
        .overlay{
            ZStack {
                if let selectedCast {
                Color.backgroundColor
                    .opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            self.selectedCast = nil
                        }
                    }
                
                    PopupCastView(castMember: selectedCast)
                        .onTapGesture {
                            withAnimation {
                                self.selectedCast = nil
                            }
                        }
                        .matchedGeometryEffect(id: selectedCast.id, in: namespace)
                        .frame(width: UIScreen.screenWidth * 0.6, height: UIScreen.screenHeight * 0.3)
                }
            }
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
                LazyHStack(spacing: 0) {
                    ForEach(detailVM.cast) { castMember in
                        if selectedCast != castMember {
                            CastCard(castMember: castMember)
                                .matchedGeometryEffect(id: castMember.id, in: namespace)
                                .onTapGesture {
                                    withAnimation {
                                        if self.selectedCast != nil {
                                            self.selectedCast = nil
                                        } else {
                                            self.selectedCast = castMember
                                        }
                                    }
                                }
                                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
            }
        }
    }
}


