//
//  HomeNavigationContainer.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI

struct HomeNavigationContainer: View {
    
    // This is where the home navigation interactor is created
    @StateObject private var homeNavigationInteractor = HomeNavigationInteractor()
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    @ObservedObject var authInteractor : AuthInteractor
    
    var body: some View {
        
        NavigationStack(path: $homeNavigationInteractor.homePath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor)
            }
            .navigationDestination(for: AppPath.self) { homePath in
                switch homePath {
                case .home:
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor)
                    }
                    
                case .detail(let motionPicture):
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        MotionPictureDetailView(motionPicture, favouritesInteractor, apiDataInteractor)
                    }
                    
                case .favourites:
                    EmptyView()
                }
            }
            .sheet(isPresented: $homeNavigationInteractor.showSignIn) {
                RegisterView(authInteractor)
                    .presentationDetents([.large])
            }
        }
    }
}
