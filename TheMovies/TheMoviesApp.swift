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
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.urlImageService, urlImageService)
        }
    }
}
