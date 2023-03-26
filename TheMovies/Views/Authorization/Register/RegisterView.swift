//
//  RegisterView.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var registerVM : RegisterViewModel
    @Binding var showSignIn : Bool
    
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor, _ showSignIn : Binding<Bool>) {
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authInteractor, appInteractor))
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

extension RegisterView {
    
    private var textfields : some View {
        VStack(spacing: 20) {
            Textfield(text: $registerVM.email, title: "Email", isSecure: false, isValid: registerVM.emailHasRedBorder())
            
            Textfield(text: $registerVM.password, title: "Password", isSecure: true, isValid: registerVM.passwordHasRedBorder())
            
            Textfield(text: $registerVM.confirmedPassword, title: "Confirm Password", isSecure: true, isValid: registerVM.confirmedPasswordHasRedBorder())
            
            Button {
                withAnimation {
                    showSignIn = true
                }
            } label: {
                Text("Already have an account? Sign in here!")
                    .foregroundColor(Color.accentColor)
                    .font(.caption)
                    .underline()
            }
            .padding(.bottom, 15)
        }
    }
    
    private var registerButton : some View {
        Button {
            if !registerVM.isLoading {
                registerVM.register()
            }
        } label: {
            if registerVM.isLoading {
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
                Text("Register")
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
        .disabled(!registerVM.readyToRegister())
    }
}
