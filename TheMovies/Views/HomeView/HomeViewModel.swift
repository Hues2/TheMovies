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
    @Published var popularMovies = [MotionPictureData.MotionPicture]()
    @Published var topRatedMovies = [MotionPictureData.MotionPicture]()
    @Published var upcomingMovies = [MotionPictureData.MotionPicture]()
    @Published var trendingMovies = [MotionPictureData.MotionPicture]()
    
    @Published var currentMovieTabIndex : Int = 0
    
    // TV Series
    @Published var popularTVSeries = [MotionPictureData.MotionPicture]()
    @Published var topRatedTVSeries = [MotionPictureData.MotionPicture]()
    @Published var airingTodayTVSeries = [MotionPictureData.MotionPicture]()
    @Published var trendingTVSeries = [MotionPictureData.MotionPicture]()
    
    @Published var currentTVTabIndex : Int = 0
    
    // Sets the view to either display Movies or TV Series
    @Published var selectedType : MotionPictureData.MotionPicture.MotionPictureType = .movie
    
    
    
    // Interactor Dependencies
    let homeNavigationInteractor : HomeNavigationInteractor
    let apiInteractor : APIDataInteractor
    
    
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiInteractor : APIDataInteractor) {
        self.homeNavigationInteractor = homeNavigationInteractor
        self.apiInteractor = apiInteractor
        
        // Add the Combine subscribers
        addMovieSubscribers()
        addTVSubscribers()
        addOtherSubscribers()
        
        
        // Get all data for the home view
        apiInteractor.getMotionPictures(URLBuilder.shared.movieURL(.trending, 1), .trending, .movie)
    }
    
    // MARK: Movie Subscribers
    private func addMovieSubscribers(){
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
            .store(in: &CancelStore.shared.cancellables)
        
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
            .store(in: &CancelStore.shared.cancellables)
        
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
            .store(in: &CancelStore.shared.cancellables)
        
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
                    print("TRENDING RECEIVED")
                }
            }
            .store(in: &CancelStore.shared.cancellables)
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
            .store(in: &CancelStore.shared.cancellables)
        
        // Popular Subscriber
        self.apiInteractor.popularTVPublisher
            .dropFirst()
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
            .store(in: &CancelStore.shared.cancellables)
        
        // Top Rated Subscriber
        self.apiInteractor.topRatedTVPublisher
            .dropFirst()
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
            .store(in: &CancelStore.shared.cancellables)
        
        // Upcoming Subscriber
        self.apiInteractor.airingTodayTVPublisher
            .dropFirst()
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
            .store(in: &CancelStore.shared.cancellables)
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
            .store(in: &CancelStore.shared.cancellables)
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
