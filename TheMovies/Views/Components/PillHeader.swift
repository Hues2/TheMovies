//
//  PillHeader.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import SwiftUI

struct PillHeader: View {
    let leftTitle : String
    let rightTitle : String
    let selectedType : MotionPictureType?
    let selectedViewType : FavouritesViewModel.ViewType?
    let leftAction : () -> Void
    let rightAction : () -> Void
    
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            typeButton("\(leftTitle)", .movie, .grid, leftAction)
                .frame(width: 150)
            
            typeButton("\(rightTitle)", .tv, .list, rightAction)
                .frame(width: 150)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            Color.backgroundColor
                .cornerRadius(30)
                .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
                .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
        }
        .gesture(DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.width > 0 {
                                withAnimation {
                                    rightAction()
                                }
                            } else {
                                withAnimation {
                                    leftAction()
                                }
                            }
                        }
                    )
        .frame(height: 50)
    }
}

extension PillHeader {

    private func typeButton(_ text : String, _ type : MotionPictureType, _ viewType : FavouritesViewModel.ViewType, _ action : @escaping () -> Void ) -> some View {
        Text ("\(text)")
            .font(.callout)
            .foregroundColor(.textColor)
            .fontWeight(.semibold)
            .padding(10)
            .onTapGesture {
                withAnimation {
                    action()
                }
            }
            .background {
                if let selectedType {
                    if selectedType == type {
                        Color.accentColor
                            .cornerRadius(30)
                            .matchedGeometryEffect(id: "pill", in: namespace)
                            .frame(width: 100)
                    }
                } else if let selectedViewType {
                    if selectedViewType == viewType {
                        Color.accentColor
                            .cornerRadius(30)
                            .matchedGeometryEffect(id: "pill", in: namespace)
                            .frame(width: 100)
                    }
                }
            }
            .padding(.horizontal, 20)
    }
    
}
