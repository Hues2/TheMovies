//
//  HapticFeedback.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI


class HapticFeedback {
    
    static let shared = HapticFeedback()
    
    private init () { }
    
    func impact(_ style : UIImpactFeedbackGenerator.FeedbackStyle) {
        let impact = UIImpactFeedbackGenerator(style: style)
        impact.impactOccurred()
    }
}
