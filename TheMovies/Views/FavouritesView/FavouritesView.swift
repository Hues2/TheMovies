//
//  FavouritesView.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import SwiftUI
import URLImage

struct FavouritesView: View {
    
    @StateObject private var favouritesVM : FavouritesViewModel
    @Namespace private var namespace
    
    init(_ favouritesNavigationInteractor : FavouritesNavigationInteractor, _ apiDataInteractor : APIDataInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self._favouritesVM = StateObject(wrappedValue: FavouritesViewModel(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backgroundColor
                .ignoresSafeArea()
            
            List {
                ForEach(favouritesVM.favouriteMotionPictures) { motionPicture in
                    favouriteCell(motionPicture)
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.backgroundColor)
                        .frame(height: 175)
                        .background(Color.backgroundColor.cornerRadius(10, corners: .allCorners).shadow(radius: 3))
                        .background(NavigationLink(value: FavouritesNavigationInteractor.FavouritesPath.detail(motionPicture), label: {
                            Color.clear
                        }))
                }
            }
            .listStyle(.plain)
            .background(Color.backgroundColor)
            .padding(.top, 60)
            
            PillHeader(leftTitle: "Grid", rightTitle: "List", selectedType: nil, selectedViewType: favouritesVM.selectedViewType) {
                favouritesVM.selectedViewType = .grid // Swipe Left
            } rightAction: {
                favouritesVM.selectedViewType = .list // Swipe Right
            }
            
        }
    }
}


extension FavouritesView {
    
    private func favouriteCell(_ motionPicture : MotionPictureData.MotionPicture) -> some View {
        HStack(spacing: 20) {
            if let imageURL = motionPicture.posterURL {
                URLImage(imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                
                .frame(width: 100, height: 130)
                .cornerRadius(10, corners: .allCorners)
                .clipped()
            }
    
            VStack {
                Text("\(motionPicture.title ?? motionPicture.name ?? "Unknown")")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .frame(height: 130)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
