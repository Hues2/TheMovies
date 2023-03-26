//
//  AccountView.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var accountVM : AccountViewModel
    
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self._accountVM = StateObject(wrappedValue: AccountViewModel(authInteractor, appInteractor))
    }
    
    var body: some View {
        
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            VStack {
                if accountVM.authInteractor.user != nil {
                    signOutButton
                } else {
                    signInButton
                }
            }
            .padding()
        }
    }
}

extension AccountView {
    
    private var signOutButton : some View {
        Button {
            accountVM.signOut()
        } label: {
            Text("Sign Out")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    Color.accentColor
                }
                .cornerRadius(10, corners: .allCorners)
                .shadow(radius: 3)
        }

    }
    
    private var signInButton : some View {
        Button {
            accountVM.signIn()
        } label: {
            Text("Sign In")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    Color.accentColor
                }
                .cornerRadius(10, corners: .allCorners)
                .shadow(radius: 3)
        }
    }
    
}
