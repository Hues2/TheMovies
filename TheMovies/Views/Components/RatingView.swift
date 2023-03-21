//
//  RatingView.swift
//  TheMovies
//
//  Created by Greg Ross on 20/03/2023.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Double
    let frameSize : CGFloat
    
    var color: Color{
        if rating > 3{
            if rating < 7{
                return .orange
            } else{
                return .green
            }
        } else {
            return .red
        }
    }
    
    @State var percentToAnimate: Double = 0
    
    var body: some View {
        ZStack{
            
            Circle()
                .stroke(color.opacity(0.15), lineWidth: 2)
            
            Circle()
                .trim(from: 1 - percentToAnimate, to: 1)
                .stroke(color.opacity(0.8), lineWidth: 2)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .shadow(color: color.opacity(0.5), radius: 3, x: 0, y: 0)
                .shadow(color: color.opacity(0.5), radius: 3, x: 0, y: 0)
            
        }
        .overlay(alignment: .center) {
            Text("\(rating.ratingToPercent())")
                .foregroundColor(color)
                .font(.caption2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .frame(maxWidth: frameSize, maxHeight: frameSize)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 1)) {
                self.percentToAnimate = rating / 10
            }
        }
    }
}
