//
//  CancelStore.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine

class CancelStore {
    static let shared = CancelStore()
    
    private init(){}
    
    var cancellables = Set<AnyCancellable>()
}
