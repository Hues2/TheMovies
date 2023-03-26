//
//  TheMoviesApp.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct TheMoviesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())
    @StateObject var appInteractor = AppInteractor()
    @StateObject var apiDataInteractor = APIDataInteractor()
    @StateObject var authInteractor = AuthInteractor()
    @StateObject var favouritesInteractor = FavouritesInteractor()
    
    var body: some Scene {
        WindowGroup {
            AppView(appInteractor, apiDataInteractor, authInteractor, favouritesInteractor)
                .environment(\.urlImageService, urlImageService)
        }
    }
}
