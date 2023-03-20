//
//  HomeNavigationContainer.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI

struct HomeNavigationContainer: View {
    
    // This is where the home navigation interactor is created
    @StateObject var homeNavigationInteractor = HomeNavigationInteractor()
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    
    var body: some View {
        
        NavigationStack(path: $homeNavigationInteractor.homePath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor)
            }
            .navigationDestination(for: HomeNavigationInteractor.HomePath.self) { homePath in
                switch homePath {
                case .home:
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor)
                    }
                    
                case .detail(let motionPicture):
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        MotionPictureDetailView(motionPicture)
                    }
                }
            }
        }
        
    }
}
