//
//  RegisterView.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var registerVM : RegisterViewModel
    
    init(_ authInteractor : AuthInteractor) {
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authInteractor))
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
        VStack(spacing: 15) {
            Textfield(text: $registerVM.email, title: "Email", isSecure: false, isValid: registerVM.emailHasRedBorder())
            
            Textfield(text: $registerVM.password, title: "Password", isSecure: true, isValid: registerVM.passwordHasRedBorder())
            
            Textfield(text: $registerVM.confirmedPassword, title: "Confirm Password", isSecure: true, isValid: registerVM.confirmedPasswordHasRedBorder())
        }
    }
    
    private var registerButton : some View {
        Button {
            registerVM.register()
        } label: {
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
        .disabled(!registerVM.readyToRegister())
    }
}
