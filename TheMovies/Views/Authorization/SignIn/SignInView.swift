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
    
    init(_ authInteractor : AuthInteractor, _ showSignIn : Binding<Bool>) {
        self._signInVM = StateObject(wrappedValue: SignInViewModel(authInteractor))
        self._showSignIn = showSignIn
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            
            Text("The Movies")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.accentColor)
            
            
            textfields
            
            registerButton

        }
        .padding()
        .contentShape(Rectangle())
        .dismissKeyboardOnTap()
    }
}

extension SignInView {
    
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
            }
        }
        .padding(.bottom, 15)
    }
    
    private var registerButton : some View {
        Button {
            signInVM.signIn()
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
        .disabled(!signInVM.readyToSignIn())
    }
}

