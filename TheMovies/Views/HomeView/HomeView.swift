//
//  HomeView.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI
import URLImage
import URLImageStore

struct HomeView: View {
    
    @StateObject private var homeVM : HomeViewModel
    
    @Namespace private var namespace
    
    
    
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiDataInteractor : APIDataInteractor) {
        self._homeVM = StateObject(wrappedValue: HomeViewModel(homeNavigationInteractor, apiDataInteractor))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView {
                
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    
                    // Movie/TV View
                    if homeVM.selectedType == .movie {
                        movieView
                            .transition(.move(edge: .leading))
                    } else {
                        tvView
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            
            // Type buttons
            typeButtons
                .frame(height: 50)
        }
    }
}

// MARK: Type Buttons
extension HomeView {
    
    private var typeButtons : some View {
        HStack {
            typeButton("Movies", .movie)
                .frame(width: 150)
            
            typeButton("TV Series", .tv)
                .frame(width: 150)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            Color.backgroundColor
                .cornerRadius(30)
                .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
                .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
        }
        .gesture(DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.width > 0 {
                                withAnimation {
                                    homeVM.selectedType = .tv // swipe right
                                }
                            } else {
                                withAnimation {
                                    homeVM.selectedType = .movie  // swipe left
                                }
                            }
                        }
                    )
        
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
                            .frame(width: 100)
                    }
            }
            .padding(.horizontal, 20)
    }
    
}


// MARK: Main View
extension HomeView {
    
    private var movieView : some View {
        sharedView
    }
    
    private var tvView : some View {
        sharedView
    }
    
    private var sharedView : some View {
        VStack(spacing: 40) {
            trendingTabView(homeVM.selectedType == .movie ? homeVM.trendingMovies : homeVM.trendingTVSeries)
                .frame(height: UIScreen.screenHeight * 0.65)
                .padding(.top)
            
            categoryList("Top Rated", homeVM.selectedType == .movie ? homeVM.topRatedMovies : homeVM.topRatedTVSeries)
                    .padding()
            
            categoryList("Popular", homeVM.selectedType == .movie ? homeVM.popularMovies : homeVM.popularTVSeries)
                    .padding()
            
            categoryList(homeVM.selectedType == .movie ? "Upcoming" : "Airing Today", homeVM.selectedType == .movie ? homeVM.upcomingMovies : homeVM.airingTodayTVSeries)
                    .padding()
            
        }
        .animation(.none, value: homeVM.selectedType)

    }
    
}



// MARK: TabView
extension HomeView {
    
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
    
    @ViewBuilder
    private func tabViewCard(_ motionpicture : MotionPictureData.MotionPicture) -> some View {
        if let url = motionpicture.imageURL {
            
            URLImage(url) {
                tabViewLoadingCard
            } inProgress: { progress in
                tabViewLoadingCard
            } failure: { error, retry in
                tabViewLoadingCard
            } content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.6)
                    .clipped()
                    .overlay(alignment: .topTrailing) {
                        ZStack {
                            Color.black
                                .opacity(0.4)
                                .cornerRadius(10, corners: [.topRight, .bottomLeft])

                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                        .frame(width: 50, height: 50)
                    }
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
    }
    
    
    private var tabViewLoadingCard : some View {
        ZStack {
            Color.backgroundColor
            ProgressView()
        }
        .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.6)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
}

// MARK: Horizontal Scrollview
extension HomeView {
    
    private func categoryList(_ category : String, _ motionPictures : [MotionPictureData.MotionPicture]) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("\(category)")
                .font(.title2)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(motionPictures) { motionPicture in
                        NavigationLink(value: HomeNavigationInteractor.HomePath.detail(motionPicture)) {
                            miniMotionPictureCard(motionPicture)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func miniMotionPictureCard(_ motionPicture : MotionPictureData.MotionPicture) -> some View {
        
        if let url = motionPicture.imageURL {
            URLImage(url) {
                ZStack {
                    Color.backgroundColor
                        .shadow(radius: 5)
                    ProgressView()
                }
            } inProgress: { progress in
                ZStack {
                    Color.backgroundColor
                        .shadow(radius: 5)
                    ProgressView()
                }
            } failure: { error, retry in
                ZStack {
                    Color.backgroundColor
                        .border(.black)
                        .shadow(radius: 5)
                    ProgressView()
                }
            } content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .overlay(alignment: .topTrailing) {
                        ZStack {
                            Color.black
                                .opacity(0.4)
                                .cornerRadius(10, corners: [.topRight, .bottomLeft])
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.headline)
                                .scaledToFit()
                            
                            
                        }
                        .frame(width: 25, height: 25)
                    }
            }
            .frame(width: 130, height: 200)
            .cornerRadius(10)
        }
    }
    
}
