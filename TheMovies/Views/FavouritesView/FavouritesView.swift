//
//  FavouritesView.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var favouritesVM : FavouritesViewModel
    @Namespace private var namespace
    
    init(_ favouritesNavigationInteractor : FavouritesNavigationInteractor, _ apiDataInteractor : APIDataInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self._favouritesVM = StateObject(wrappedValue: FavouritesViewModel(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor))
    }
    
    var body: some View {
        Text("Favourites View")
    }
}
