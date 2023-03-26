//
//  AuthorizationSheetView.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import SwiftUI

struct AuthorizationSheetView: View {
    
    @ObservedObject var authInteractor : AuthInteractor
    @State private var showSignIn : Bool = true
    
    var body: some View {
        
        if showSignIn {
            SignInView(authInteractor, $showSignIn)
                .transition(.move(edge: .leading))
        } else {
           RegisterView(authInteractor, $showSignIn)
                .transition(.move(edge: .trailing))
        }
        
    }
}
