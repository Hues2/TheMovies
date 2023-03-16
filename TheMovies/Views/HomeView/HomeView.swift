//
//  HomeView.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeVM : HomeViewModel
    
    @Namespace private var namespace
    
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiDataInteractor : APIDataInteractor) {
        self._homeVM = StateObject(wrappedValue: HomeViewModel(homeNavigationInteractor, apiDataInteractor))
    }
    
    var body: some View {

        VStack {
            
            // Type buttons
            typeButtons
            
            // Movie/TV View
            if homeVM.selectedType == .movie {
                movieView
                    .transition(.move(edge: .leading))
            } else {
                tvView
                    .transition(.move(edge: .trailing))
            }
            Spacer()
        }
        
        
            
    }
}


extension HomeView {
    
    private var typeButtons : some View {
        HStack {
            typeButton("Movies", .movie)
            
            typeButton("TV Series", .tv)
        }
    }
    
    private func typeButton(_ text : String, _ type : MotionPictureData.MotionPicture.MotionPictureType ) -> some View {
        Text ("\(text)")
            .font(.callout)
            .foregroundColor(.textColor)
            .fontWeight(.semibold)
            .padding(10)
            .onTapGesture {
                withAnimation {
                    if type == .movie {
                        homeVM.selectedType = .movie
                    } else {
                        homeVM.selectedType = .tv
                    }
                }
            }
            .background {
                if homeVM.selectedType == type {
                    Color.accentColor
                        .cornerRadius(30)
                        .matchedGeometryEffect(id: "pill", in: namespace)
                }
            }
            .padding(.trailing, 20)
    }
    
}


extension HomeView {
    
    private var movieView : some View {
        sharedView
    }
    
    private var tvView : some View {
        sharedView
    }
    
    private var sharedView : some View {
        VStack {
            // Trending Movie Cards
            trendingTabView(homeVM.selectedType == .movie ? homeVM.trendingMovies : homeVM.trendingTVSeries)
            
            
        }
    }
    
    private func trendingTabView(_ motionPictures : [MotionPictureData.MotionPicture]) -> some View {
        TabView(selection: homeVM.selectedType == .movie ? $homeVM.currentMovieTabIndex : $homeVM.currentTVTabIndex) {
            ForEach(Array(zip(motionPictures.indices, motionPictures)), id: \.0) { (index, motionpicture) in
                NavigationLink(value: HomeNavigationInteractor.HomePath.detail(motionpicture)) {
                    tabViewCard(motionpicture)
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    private func tabViewCard(_ motionpicture : MotionPictureData.MotionPicture) -> some View {
        ZStack {
            AsyncImage(url: motionpicture.imageURL) { image in
                image.resizable()
                    .scaledToFit()
                    .shadow(radius: 5)
            } placeholder: {
                Color.black
            }

        }
        .cornerRadius(10)
        .padding(10)
        .frame(maxHeight: 500)
    }
    
}
