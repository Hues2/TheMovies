//
//  HomeViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine
import SwiftUI


final class HomeViewModel : ObservableObject {
    
    // Movies
    @Published var trendingMovies = [MotionPictureData.MotionPicture]()
    @Published var popularMovies = [MotionPictureData.MotionPicture]()
    @Published var topRatedMovies = [MotionPictureData.MotionPicture]()
    @Published var upcomingMovies = [MotionPictureData.MotionPicture]()
    
    // Keeps track of the tabview index for the movies view
    @Published var currentMovieTabIndex : Int = 0
    
    // TV Series
    @Published var trendingTVSeries = [MotionPictureData.MotionPicture]()
    @Published var popularTVSeries = [MotionPictureData.MotionPicture]()
    @Published var topRatedTVSeries = [MotionPictureData.MotionPicture]()
    @Published var airingTodayTVSeries = [MotionPictureData.MotionPicture]()
    
    // Keeps track of the tabview index for the tv series view
    @Published var currentTVTabIndex : Int = 0
    
    // Sets the view to either display Movies or TV Series
    @Published var selectedType : MotionPictureType = .movie
    
    // Since none of the lists in this view model change when the favourites list changes,
    // this boolean "flag" is implemented, so that when a favourite is added or removed,
    // this view model knows, and then the view will re-render
    @Published var favouritesChanged : Bool = false
    
    @Published var autoSwipe : Bool = true
    
    
    // Interactor Dependencies
    let homeNavigationInteractor : HomeNavigationInteractor
    let apiInteractor : APIDataInteractor
    let favouritesInteractor : FavouritesInteractor
    let authInteractor : AuthInteractor
    let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    // Init
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiInteractor : APIDataInteractor,
         _ favouritesInteractor : FavouritesInteractor, _ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self.homeNavigationInteractor = homeNavigationInteractor
        self.apiInteractor = apiInteractor
        self.favouritesInteractor = favouritesInteractor
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
        
        // Add the Combine subscribers
        addSubscribers()
        getMovieData()
    }
}

// MARK: Favourites Functionality
extension HomeViewModel {
    
    // Add motion Picture To Favourites
    func alterFavourites(_ motionPicture : MotionPictureData.MotionPicture) {
        guard authInteractor.user != nil else {
            // Show Sign In
            self.appInteractor.showSignIn = true
            return
        }
        self.favouritesInteractor.alterFavourites(motionPicture)
    }
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite(_ motionPicture : MotionPictureData.MotionPicture) -> Bool {
        favouritesInteractor.isFavourite(motionPicture)
    }
    
}

// MARK: Get Data
extension HomeViewModel {
    
    // Get all data for the home view
    private func getMovieData() {
        apiInteractor.getMotionPictures(URLBuilder.shared.movieURL(.trending, 1), .trending, .movie)
        apiInteractor.getMotionPictures(URLBuilder.shared.movieURL(.popular, 1), .popular, .movie)
        apiInteractor.getMotionPictures(URLBuilder.shared.movieURL(.topRated, 1), .topRated, .movie)
        apiInteractor.getMotionPictures(URLBuilder.shared.movieURL(.upcoming, 1), .upcoming, .movie)
    }
    
    // Get TV data
    // I don't want to call all api endpoints if not necessary
    private func getTVData(){
        if popularTVSeries.isEmpty {
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.popular, 1), .popular, .tv)
        }
        
        if topRatedTVSeries.isEmpty {
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.topRated, 1), .topRated, .tv)
        }
        
        if airingTodayTVSeries.isEmpty {
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.airingToday, 1), .airingToday, .tv)
        }
        
        if trendingTVSeries.isEmpty {
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.trending, 1), .trending, .tv)
        }
    }
    
}

// MARK: Subscribers
extension HomeViewModel {
    
    private func addSubscribers() {
        addMovieSubscribers()
        addTVSubscribers()
        addOtherSubscribers()
    }
    
    // MARK: Movie Subscribers
    private func addMovieSubscribers(){
        // Trending Subscriber
        self.apiInteractor.trendingMoviesPublisher
            .dropFirst()
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.trendingMovies = motionPictures.shuffled()
                }
            }
            .store(in: &cancellables)
        
        // Popular Subscriber
        self.apiInteractor.popularMoviesPublisher
            .dropFirst()
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.popularMovies = motionPictures
                }
            }
            .store(in: &cancellables)
        
        // Top Rated Subscriber
        self.apiInteractor.topRatedMoviesPublisher
            .dropFirst()
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.topRatedMovies = motionPictures
                }
            }
            .store(in: &cancellables)
        
        // Upcoming Subscriber
        self.apiInteractor.upcomingMoviesPublisher
            .dropFirst()
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.upcomingMovies = motionPictures
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: TV Subscribers
    private func addTVSubscribers() {
        // Trending Subscriber
        self.apiInteractor.trendingTVPublisher
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.trendingTVSeries = motionPictures.shuffled()
                }
            }
            .store(in: &cancellables)
        
        // Popular Subscriber
        self.apiInteractor.popularTVPublisher
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.popularTVSeries = motionPictures
                }
            }
            .store(in: &cancellables)
        
        // Top Rated Subscriber
        self.apiInteractor.topRatedTVPublisher
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.topRatedTVSeries = motionPictures
                }
            }
            .store(in: &cancellables)
        
        // Upcoming Subscriber
        self.apiInteractor.airingTodayTVPublisher
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult {
                case .failure(let customError):
                    /// Maybe do something with the error
                    print(customError)
                    
                case .success(let optionalListOfMotionPictures):
                    guard let motionPictures = optionalListOfMotionPictures else { return }
                    self.airingTodayTVSeries = motionPictures
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: Other Subscribers
    private func addOtherSubscribers() {
        // When user taps on TV, we need to get the TV data from the endpoint
        self.$selectedType
            .dropFirst()
            .sink { [weak self] returnedType in
                guard let self else { return }
                if returnedType == .tv {
                    self.getTVData()
                }
            }
            .store(in: &cancellables)
                
        self.$autoSwipe
            .sink { [weak self] returnedBool in
                guard let self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.shared.autoSwipeSeconds) {
                    if self.selectedType == .movie {
                        withAnimation {
                            if self.currentMovieTabIndex == self.trendingMovies.count - 1 {
                                self.currentMovieTabIndex = 0
                            } else {
                                self.currentMovieTabIndex += 1
                            }
                            self.autoSwipe = true
                        }
                    } else {
                        withAnimation {
                            if self.currentTVTabIndex == self.trendingTVSeries.count - 1 {
                                self.currentTVTabIndex = 0
                            } else {
                                self.currentTVTabIndex += 1
                            }
                            self.autoSwipe.toggle()
                        }
                    }
                }
            }
            .store(in: &cancellables)
        
        
        self.favouritesInteractor.$favouritesToggle
            .sink { [weak self] _ in
                guard let self else { return }
                self.favouritesChanged.toggle()
            }
            .store(in: &cancellables)
    }
}
