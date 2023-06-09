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
    @ObservedObject var appInteractor : AppInteractor
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    @ObservedObject var authInteractor : AuthInteractor
    @Binding var showSignIn : Bool
    
    var body: some View {
        
        NavigationStack(path: $favouritesNavigationInteractor.favouritesPath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                FavouritesView(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor, appInteractor)
            }
            .navigationDestination(for: AppPath.self) { homePath in
                switch homePath {
                case .home:
                    EmptyView()
                case .favourites:
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        FavouritesView(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor, appInteractor)
                    }
                    
                case .detail(let motionPicture):
                    ZStack {
                        Color.backgroundColor
                            .ignoresSafeArea()
                        MotionPictureDetailView(motionPicture, favouritesInteractor, apiDataInteractor, authInteractor, appInteractor)
                    }
                }
            }
            .sheet(isPresented: $showSignIn) {
                AuthorizationSheetView(authInteractor, appInteractor)
                    .presentationDetents([.large])
            }
        }
    }
}
