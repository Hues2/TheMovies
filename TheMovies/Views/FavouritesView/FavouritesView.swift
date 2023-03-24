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
        ZStack(alignment: .top) {

            List {
                ForEach(favouritesVM.favouriteMotionPictures) { motionPicture in
                    Text("\(motionPicture.name ?? motionPicture.title ?? "Unknown")")
                }
            }
            
            PillHeader(leftTitle: "Grid", rightTitle: "List", selectedType: nil, selectedViewType: favouritesVM.selectedViewType) {
                favouritesVM.selectedViewType = .grid // Swipe Left
            } rightAction: {
                favouritesVM.selectedViewType = .list // Swipe Right
            }
            
        }
        .frame(maxWidth: .infinity)
    }
}
