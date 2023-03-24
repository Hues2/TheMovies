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
    
    @StateObject private var appVM = AppViewModel()
    @StateObject var apiDataInteractor = APIDataInteractor()
    @StateObject var favouritesInteractor = FavouritesInteractor()
    
    
    var body: some View {
        
        TabView(selection: $appVM.selectedTab) {
            
            HomeNavigationContainer(apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("home_tab_title")
                    }
                }
                .tag(AppViewModel.Tab.home)
            
            FavouritesNavigationContainer(apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor)
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("favourites_tab_title")
                    }
                }
                .tag(AppViewModel.Tab.favourites)
            
        }
        
    }
}

