//
//  SignInView.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var signInVM : SignInViewModel
    @Binding var showSignIn : Bool
    
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor, _ showSignIn : Binding<Bool>) {
        self._signInVM = StateObject(wrappedValue: SignInViewModel(authInteractor, appInteractor))
        self._showSignIn = showSignIn
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
                .dismissKeyboardOnTap()
            
            VStack(alignment: .center, spacing: 30) {
                
                Text("The Movies")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(Color.accentColor)
                
                errorMessage
                
                textfields
                
                registerButton
                
            }
            .padding()
        }
    }
}

extension SignInView {
    
    @ViewBuilder
    private var errorMessage : some View {
        if let errorMessage = signInVM.errorMessage {
            Text("\(errorMessage)")
                .font(.title3)
                .fontWeight(.medium)
                .padding()
                .background(Color.backgroundColor
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10, corners: .allCorners)
                    .shadow(radius: 3))
        }
    }
    
    private var textfields : some View {
        VStack(alignment: .center, spacing: 20) {
            Textfield(text: $signInVM.email, title: "Email", isSecure: false, isValid: true)
            
            Textfield(text: $signInVM.password, title: "Password", isSecure: true, isValid: true)
            
            Button {
                withAnimation {
                    showSignIn = false
                }
            } label: {
                Text("Don't have an account? Register here!")
                    .foregroundColor(Color.accentColor)
                    .font(.caption)
                    .underline()
                    .padding()
            }
        }
        .padding(.bottom, 15)
    }
    
    private var registerButton : some View {
        Button {
            if !signInVM.isLoading {
                signInVM.signIn()
            }
        } label: {
            if signInVM.isLoading {
                ProgressView()
                    .tint(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.accentColor
                    }
                    .cornerRadius(10, corners: .allCorners)
                    .shadow(radius: 3)
            } else {
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
        .disabled(!signInVM.readyToSignIn())
    }
}

