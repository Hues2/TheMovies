//
//  PopUpCastView.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI

struct PopupCastView: View {
    
    let castMember: CastData.Cast
    
    var body: some View {
        VStack {
            Text(castMember.name ?? "Unkown")
                .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
