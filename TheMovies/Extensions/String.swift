//
//  String.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        do {
            let pattern = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
            let regex = try NSRegularExpression(pattern: pattern)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }
    
    var isValidPassword: Bool {
            do {
                let pattern = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
                let regex = try NSRegularExpression(pattern: pattern)
                return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
            } catch {
                return false
            }
        }
}
