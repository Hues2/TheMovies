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
    
    @StateObject private var appVM : AppViewModel
    
    
    // All interactors
    @ObservedObject var appInteractor : AppInteractor
    @ObservedObject var apiDataInteractor : APIDataInteractor
    @ObservedObject var authInteractor : AuthInteractor
    @ObservedObject var favouritesInteractor : FavouritesInteractor

    init(_ appInteractor : AppInteractor, _ apiDataInteractor : APIDataInteractor, _ authInteractor : AuthInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self.appInteractor = appInteractor
        self.apiDataInteractor = apiDataInteractor
        self.authInteractor = authInteractor
        self.favouritesInteractor = favouritesInteractor
        self._appVM = StateObject(wrappedValue: AppViewModel(apiDataInteractor, favouritesInteractor, authInteractor, appInteractor))
    }
    
    var body: some View {
        
        TabView(selection: $appInteractor.selectedTab) {
            
            HomeNavigationContainer(appInteractor: appInteractor, apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor, authInteractor: authInteractor, showSignIn: $appInteractor.showSignIn)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("home_tab_title")
                    }
                }
                .tag(AppInteractor.Tab.home)

            FavouritesNavigationContainer(appInteractor: appInteractor, apiDataInteractor: apiDataInteractor, favouritesInteractor: favouritesInteractor, authInteractor: authInteractor, showSignIn: $appInteractor.showSignIn)
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("favourites_tab_title")
                    }
                }
                .tag(AppInteractor.Tab.favourites)
            
            AccountView(authInteractor, appInteractor)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("account_tab_title")
                    }
                }
                .sheet(isPresented: $appInteractor.showSignIn, content: {
                    AuthorizationSheetView(authInteractor, appInteractor)
                })
                .tag(AppInteractor.Tab.account)
        }
        
    }
}

