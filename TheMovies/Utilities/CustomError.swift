//
//  CustomError.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation


enum CustomError : Error {
    case invalidUrl
    case dataCouldNotBeDecoded(String)
    
    var message : String {
        switch self {
        case .invalidUrl:
            return "The provided URL is invalid."
            
        case .dataCouldNotBeDecoded(let errorMessage):
            return "The data received from the API could not be decoded. this is the error response message: \(errorMessage)"
        }
    }
}
