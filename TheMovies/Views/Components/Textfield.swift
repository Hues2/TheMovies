//
//  Textfield.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI

struct Textfield: View {
    
    let text : Binding<String>
    let title : String
    let isSecure : Bool
    let isValid : Bool
    
    var body: some View {
        VStack {
            if !isSecure {
                TextField(title, text: text)
                    .keyboardType(.emailAddress)
            } else {
                SecureField(title, text: text)
                    .keyboardType(.default)
            }
        }
        .padding()
        .background(content: {
            Color.backgroundColor
        })
        .cornerRadius(10, corners: .allCorners)
        .shadow(radius: 3)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isValid ? Color.clear : Color.red)
        }
    }
}
