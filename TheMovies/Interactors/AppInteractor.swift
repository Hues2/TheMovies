//
//  AppInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation


final class AppInteractor : ObservableObject {
    
    @Published var showSignIn : Bool = false
    @Published var selectedTab : Tab = .home
    
    enum Tab {
        case home
        case favourites
    }
    
}
