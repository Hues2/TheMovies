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
    
    var body: some View {
        
        NavigationStack(path: $homeNavigationInteractor.homePath) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea()
                
                HomeView(homeNavigationInteractor, apiDataInteractor)
                    .navigationDestination(for: HomeNavigationInteractor.HomePath.self) { homePath in
                        switch homePath {
                        case .home:
                            HomeView(homeNavigationInteractor, apiDataInteractor)
                            
                        case .detail(let motionPicture):
                            MotionPictureDetailView(motionPicture)
                        }
                    }
            }
        }
        
    }
}
