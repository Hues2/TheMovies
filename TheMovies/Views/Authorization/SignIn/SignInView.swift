//
//  SignInView.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var signInVM : SignInViewModel
    
    init() {
        self._signInVM = StateObject(wrappedValue: SignInViewModel())
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
