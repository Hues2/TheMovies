//
//  APIDataInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine


class APIDataInteractor : ObservableObject {
    // Movies for the home view
    var popularMoviesPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var topRatedMoviesPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var upcomingMoviesPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var trendingMoviesPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var recommendedMoviesPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    
    
    // TV Series for the home view
    var popularTVPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var topRatedTVPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var trendingTVPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var airingTodayTVPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    var recommendedTVPublisher = PassthroughSubject<Result<[MotionPictureData.MotionPicture]?, CustomError>, Never>()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    
    // This fetches a list of movies from a certain category (depending on the URL)
    func getMotionPictures(_ url : String, _ publisher : MotionPicturePublisher, _ type : MotionPictureData.MotionPicture.MotionPictureType) {
        guard let url = URL(string: url) else {
            popularMoviesPublisher.send(.failure(.invalidUrl))
            return
        }
        
        getData(url)
            .decode(type: MotionPictureData.self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                guard let self else { return }
                self.handleCompletion(completion: completion, publisher, type)
            } receiveValue: { [weak self] motionPictureData in
                guard let self else { return }
                self.handleReceivedValue(publisher, type, motionPictureData)
            }
            .store(in: &cancellables)
    }
    
    private func getData(_ url : URL) -> AnyPublisher<Data, URLError>{
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    
    private func handleCompletion(completion : Subscribers.Completion<Error>, _ publisher : MotionPicturePublisher, _ type : MotionPictureData.MotionPicture.MotionPictureType){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            handleCompletionFailure(publisher, type, error)
        }
    }
    
    
    private func handleCompletionFailure(_ publisher : MotionPicturePublisher, _ type : MotionPictureData.MotionPicture.MotionPictureType, _ error : Error){
        switch publisher {
        case .popular:
            if type == .movie {
                self.popularMoviesPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            } else {
                self.popularTVPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
            
        case .topRated:
            if type == .movie {
                self.topRatedMoviesPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            } else {
                self.topRatedTVPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
            
        case .upcoming:
            if type == .movie {
                self.upcomingMoviesPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
            
        case .trending:
            if type == .movie {
                self.trendingMoviesPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            } else {
                self.trendingTVPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
            
        case .airingToday:
            if type == .tv {
                self.airingTodayTVPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
            
        case .recommendations:
            if type == .movie {
                self.recommendedMoviesPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            } else {
                self.recommendedTVPublisher.send(.failure(.dataCouldNotBeDecoded(error.localizedDescription)))
            }
        }
    }
    
    
    private func handleReceivedValue(_ publisher : MotionPicturePublisher, _ type : MotionPictureData.MotionPicture.MotionPictureType, _ motionPictureData : MotionPictureData){
        switch publisher {
        case .popular:
            if type == .movie {
                self.popularMoviesPublisher.send(.success(motionPictureData.results))
            } else {
                self.popularTVPublisher.send(.success(motionPictureData.results))
            }
            
        case .topRated:
            if type == .movie {
                self.topRatedMoviesPublisher.send(.success(motionPictureData.results))
            } else {
                self.topRatedTVPublisher.send(.success(motionPictureData.results))
            }
            
        case .upcoming:
            if type == .movie {
                self.upcomingMoviesPublisher.send(.success(motionPictureData.results))
            }

        case .trending:
            if type == .movie {
                self.trendingMoviesPublisher.send(.success(motionPictureData.results))
            } else {
                self.trendingTVPublisher.send(.success(motionPictureData.results))
            }
            
        case .airingToday:
            if type == .tv {
                self.airingTodayTVPublisher.send(.success(motionPictureData.results))
            }
            
        case .recommendations:
            if type == .movie {
                self.recommendedMoviesPublisher.send(.success(motionPictureData.results))
            } else {
                self.recommendedTVPublisher.send(.success(motionPictureData.results))
            }
        }
    }
    
    
    enum MotionPicturePublisher : String {
        case popular = "popular"
        case topRated = "top_rated"
        case upcoming = "upcoming"
        case trending = "trending"
        case airingToday  = "airing_today"
        case recommendations = "recommendations"
    }
    
}
