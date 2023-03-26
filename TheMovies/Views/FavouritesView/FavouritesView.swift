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
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(_ favouritesNavigationInteractor : FavouritesNavigationInteractor, _ apiDataInteractor : APIDataInteractor,
         _ favouritesInteractor : FavouritesInteractor, _ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self._favouritesVM = StateObject(wrappedValue: FavouritesViewModel(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor, authInteractor, appInteractor))
    }
    
    var body: some View {
        ZStack(alignment: .top) {

                if favouritesVM.selectedViewType == .grid {
                    grid
                        .transition(.move(edge: .leading))
                } else {
                    list
                        .transition(.move(edge: .trailing))
                }
            
            PillHeader(leftTitle: "Grid", rightTitle: "List", selectedType: nil, selectedViewType: favouritesVM.selectedViewType) {
                favouritesVM.selectedViewType = .grid // Swipe Left
            } rightAction: {
                favouritesVM.selectedViewType = .list // Swipe Right
            }
            
        }
    }
}

// MARK: Grid UI
extension FavouritesView {
    
    private var grid : some View {
        ScrollView {
            Spacer()
                .frame(height: 60)
            
            LazyVGrid(columns: columns) {
                ForEach(favouritesVM.favouriteMotionPictures) { motionPicture in
                    NavigationLink(value: AppPath.detail(motionPicture)) {
                        MiniMotionPictureCard(motionPicture: motionPicture, favouritesInteractor: favouritesVM.favouritesInteractor, authInteractor: favouritesVM.authInteractor, appInteractor: favouritesVM.appInteractor, gridCardSize: CGSize(width: UIScreen.screenWidth / 3.5, height: UIScreen.screenHeight * 0.2))
                            .cornerRadius(10, corners: .allCorners)
                            .shadow(radius: 3)
                    }
                    
                }
            }
            .animation(.easeInOut, value: favouritesVM.favouriteMotionPictures)
        }
        .padding(.horizontal)
    }
    
}

// MARK: List UI
extension FavouritesView {
    
    private var list : some View {
        List {
            Spacer()
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.backgroundColor)
                .frame(height: 40)
                .background(Color.backgroundColor.cornerRadius(10, corners: .allCorners).shadow(radius: 3))
            
            ForEach(favouritesVM.favouriteMotionPictures) { motionPicture in
                favouriteCell(motionPicture)
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.backgroundColor)
                    .frame(height: 150)
                    .background(Color.backgroundColor.cornerRadius(10, corners: .allCorners).shadow(radius: 3))
                    .background(NavigationLink(value: AppPath.detail(motionPicture), label: {
                        Color.clear
                    }))
            }
            .onDelete { indexSet in
                favouritesVM.removeFavourite(indexSet)
            }
        }
        .listStyle(.plain)
        .background(Color.backgroundColor)
    }
    
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
    
            VStack(alignment: .leading, spacing: 15) {
                Text("\(motionPicture.title ?? motionPicture.name ?? "Unknown")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    
                Spacer()
                
                VStack {
                    HStack {
                        Text("\(motionPicture.release_date ?? motionPicture.first_air_date ?? "")")
                            .fontWeight(.thin)
                        Spacer()
                        RatingView(rating: motionPicture.vote_average ?? 0, frameSize: 30, isInFavouritesList: true)
                            .frame(width: 35, height: 35)
                    }
                    
                }

            }
            .frame(height: 130)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
