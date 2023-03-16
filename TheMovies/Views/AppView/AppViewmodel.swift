//
//  AppViewmodel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


class AppViewModel : ObservableObject {
    
    @Published var selectedTab : Tab = .home
    
    
    enum Tab {
        case home
        case favourites
    }
    
}
