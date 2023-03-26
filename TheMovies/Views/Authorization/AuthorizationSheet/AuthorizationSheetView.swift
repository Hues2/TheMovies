//
//  AuthorizationSheetView.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import SwiftUI

struct AuthorizationSheetView: View {
    
    @StateObject private var authVM : AuthorizationSheetViewModel
    @ObservedObject var authInteractor : AuthInteractor
    @ObservedObject var appInteractor : AppInteractor
    @State private var showSignIn : Bool = true
    
    init(_ authInteractor: AuthInteractor, _ appInteractor: AppInteractor) {
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
        self._authVM = StateObject(wrappedValue: AuthorizationSheetViewModel(authInteractor, appInteractor))
    }
    
    var body: some View {
        
        if showSignIn {
            SignInView(authInteractor, appInteractor, $showSignIn)
                .transition(.move(edge: .leading))
        } else {
            RegisterView(authInteractor, appInteractor, $showSignIn)
                .transition(.move(edge: .trailing))
        }
    }
}

