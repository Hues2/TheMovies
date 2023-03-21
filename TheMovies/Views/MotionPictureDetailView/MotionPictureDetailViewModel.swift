//
//  MotionPictureDetailViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine


final class MotionPictureDetailViewModel : ObservableObject {
    
    let motionPicture : MotionPictureData.MotionPicture
    @Published var recommendedMotionPictures = [MotionPictureData.MotionPicture]()
    
    
    // Favourites Toggle
    @Published var favouritesChanged : Bool = false
    
    
    // Interactor Dependencies
    let favouritesInteractor : FavouritesInteractor
    let apiDataInteractor : APIDataInteractor
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ motionPicture : MotionPictureData.MotionPicture, _ favouritesInteractor : FavouritesInteractor, _ apiDataInteractor : APIDataInteractor) {
        self.motionPicture = motionPicture
        self.favouritesInteractor = favouritesInteractor
        self.apiDataInteractor = apiDataInteractor
        
        addSubscribers()
        getRecommendations()
    }
 
}



// MARK: Subscribers
extension MotionPictureDetailViewModel {
    
    private func addSubscribers() {
        addFavouritesSubscribers()
        addRecommendedSubscribers()
    }
    
    
    private func addFavouritesSubscribers() {
        self.favouritesInteractor.$favouritesToggle
            .sink { [weak self] _ in
                guard let self else { return }
                self.favouritesChanged.toggle()
            }
            .store(in: &cancellables)
    }
    
    private func addRecommendedSubscribers() {
        if motionPicture.type == .movie {
            self.apiDataInteractor.recommendedMoviesPublisher
                .sink { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .failure(let error):
                        print("The result returned from the recommended movies publisher is a failure. Custom error message: \(error)")
                    case .success(let motionPictures):
                        guard let motionPictures else { return }
                        self.recommendedMotionPictures = motionPictures
                    }
                }
                .store(in: &cancellables)
        } else {
            self.apiDataInteractor.recommendedTVPublisher
                .sink { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .failure(let error):
                        print("The result returned from the recommended movies publisher is a failure. Custom error message: \(error)")
                    case .success(let motionPictures):
                        guard let motionPictures else { return }
                        self.recommendedMotionPictures = motionPictures
                    }
                }
                .store(in: &cancellables)
        }
    }
}


// MARK: Favourites Functionality
extension MotionPictureDetailViewModel {
    // Add motion Picture To Favourites
    func alterFavourites() {
        favouritesInteractor.alterFavourites(motionPicture.id)
    }
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite() -> Bool {
        favouritesInteractor.isFavourite(motionPicture)
    }
}


// MARK: Fetch Extra Data
extension MotionPictureDetailViewModel {
    private func getRecommendations() {
        apiDataInteractor.getMotionPictures(URLBuilder.shared.getRecommendationsURL(motionPicture.type, motionPicture.id ?? 0, 1), .recommendations, motionPicture.type)
    }
}
