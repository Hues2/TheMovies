//
//  Double.swift
//  TheMovies
//
//  Created by Greg Ross on 20/03/2023.
//

import Foundation

extension Double {
    func ratingToPercent() -> String {
        let rating = self * 10
        let result = String(format: "%.0f", rating)
        return "\(result)%"
    }
}
