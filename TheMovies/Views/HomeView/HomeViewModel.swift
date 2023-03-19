//
//  HomeViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine


class HomeViewModel : ObservableObject {
    
    // UI Data Publishers
    // Movies
    @Published var trendingMovies = [MotionPictureData.MotionPicture]()
    @Published var popularMovies = [MotionPictureData.MotionPicture]()
    @Published var topRatedMovies = [MotionPictureData.MotionPicture]()
    @Published var upcomingMovies = [MotionPictureData.MotionPicture]()
    
    
    @Published var currentMovieTabIndex : Int = 0
    
    // TV Series
    @Published var trendingTVSeries = [MotionPictureData.MotionPicture]()
    @Published var popularTVSeries = [MotionPictureData.MotionPicture]()
    @Published var topRatedTVSeries = [MotionPictureData.MotionPicture]()
    @Published var airingTodayTVSeries = [MotionPictureData.MotionPicture]()
    
    
    @Published var currentTVTabIndex : Int = 0
    
    // Sets the view to either display Movies or TV Series
    @Published var selectedType : MotionPictureData.MotionPicture.MotionPictureType = .movie
    
    @Published private var favouritesChanged : Bool = false
    
    
    // Interactor Dependencies
    let homeNavigationInteractor : HomeNavigationInteractor
    let apiInteractor : APIDataInteractor
    let favouritesInteractor : FavouritesInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    // Init
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiInteractor : APIDataInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self.homeNavigationInteractor = homeNavigationInteractor
        self.apiInteractor = apiInteractor
        self.favouritesInteractor = favouritesInteractor
        
        // Add the Combine subscribers
        addSubscribers()
        
        getMovieData()
    }
    
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
            print("Fetching TV Data Again")
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.popular, 1), .popular, .tv)
        }
        
        if topRatedTVSeries.isEmpty {
            print("Fetching TV Data Again")
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.topRated, 1), .topRated, .tv)
        }
        
        if airingTodayTVSeries.isEmpty {
            print("Fetching TV Data Again")
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.airingToday, 1), .airingToday, .tv)
        }
        
        if trendingTVSeries.isEmpty {
            print("Fetching TV Data Again")
            apiInteractor.getMotionPictures(URLBuilder.shared.tvURL(.trending, 1), .trending, .tv)
        }
    }

    
    // Add motion Picture To Favourites
    func alterFavourites(_ motionPicture : MotionPictureData.MotionPicture) {
        favouritesInteractor.alterFavourites(motionPicture.id)
        favouritesChanged.toggle() // --> This published var makes the image card re-render to display the favourite heart
    }
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite(_ motionPicture : MotionPictureData.MotionPicture) -> Bool {
        guard let id = motionPicture.id else { return false }
        let index = favouritesInteractor.favouriteIDs.firstIndex(of: id)
        return index == nil ? false : true
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
                    print("POPULAR RECEIVED")
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
                    print("TOP RATED RECEIVED")
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
                    print("UPCOMING RECEIVED")
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
                    print("TRENDING RECEIVED")
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
                    print("POPULAR RECEIVED")
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
                    print("TOP RATED RECEIVED")
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
                    print("UPCOMING RECEIVED")
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
    }
}
