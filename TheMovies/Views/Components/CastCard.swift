//
//  CastCard.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI
import URLImage

struct CastCard : View {
    
    let castMember : CastData.Cast
    
    var body: some View {
        VStack {
            if let imageURL = castMember.imageURL {
                URLImage(imageURL) {
                    loadingCastCard
                } inProgress: { progress in
                    loadingCastCard
                } failure: { error, retry in
                    loadingCastCard
                } content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 150, alignment: .center)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }

            }
        }
    }
}

extension CastCard {
    
    private var loadingCastCard : some View {
        ZStack {
            Color.backgroundColor
            ProgressView()
                .tint(Color.accentColor)
        }
        .frame(width: 140, height: 150, alignment: .center)
        .padding(.horizontal)
        .clipShape(Circle())
        .shadow(radius: 3)
    }
    
}
