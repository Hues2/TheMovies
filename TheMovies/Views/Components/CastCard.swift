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
                URLImage(imageURL) { image, info in
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
