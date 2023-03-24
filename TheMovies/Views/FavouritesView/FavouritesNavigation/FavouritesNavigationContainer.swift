//
//  FavouritesNavigationContainer.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import SwiftUI

struct FavouritesNavigationContainer: View {
    // This is where the home navigation interactor is created
    @StateObject var favouritesNavigationInteractor = FavouritesNavigationInteractor()
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    
    var body: some View {
        
        NavigationStack(path: $favouritesNavigationInteractor.favouritesPath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                FavouritesView(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor)
            }
            .navigationDestination(for: HomeNavigationInteractor.HomePath.self) { homePath in
                switch homePath {
                case .home:
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        FavouritesView(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor)
                    }
                    
                case .detail(let motionPicture):
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        MotionPictureDetailView(motionPicture, favouritesInteractor, apiDataInteractor)
                    }
                }
            }
        }
        
    }
}
