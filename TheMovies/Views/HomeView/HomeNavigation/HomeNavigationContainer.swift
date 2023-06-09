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
    @ObservedObject var appInteractor : AppInteractor
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    @ObservedObject var authInteractor : AuthInteractor
    @Binding var showSignIn : Bool
    
    var body: some View {
        
        NavigationStack(path: $homeNavigationInteractor.homePath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor, appInteractor)
            }
            .navigationDestination(for: AppPath.self) { homePath in
                switch homePath {
                case .home:
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        HomeView(homeNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor, appInteractor)
                    }
                    
                case .detail(let motionPicture):
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        MotionPictureDetailView(motionPicture, favouritesInteractor, apiDataInteractor, authInteractor, appInteractor)
                    }
                    
                case .favourites:
                    EmptyView()
                }
            }
            .sheet(isPresented: $showSignIn) {
                AuthorizationSheetView(authInteractor, appInteractor)
                    .presentationDetents([.large])
            }
        }
    }
}
