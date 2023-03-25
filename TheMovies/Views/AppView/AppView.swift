//
//  AppView.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI


// This is the main view for the app
// All views will belong to this "parent view"

struct AppView: View {
    
    // Initialise all global interactors
    @StateObject private var appInteractor = AppInteractor()
    @StateObject private var authInteractor = AuthInteractor()
    @StateObject private var apiDataInteractor = APIDataInteractor()
    @StateObject private var favouritesInteractor = FavouritesInteractor()
    
    var body: some View {
        
        TabView(selection: $appInteractor.selectedTab) {
            
            HomeNavigationContainer(apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor, authInteractor: authInteractor)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("home_tab_title")
                    }
                }
                .tag(AppInteractor.Tab.home)
            
            FavouritesNavigationContainer(apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor, authInteractor: authInteractor)
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("favourites_tab_title")
                    }
                }
                .tag(AppInteractor.Tab.favourites)
            
        }
        
    }
}

