//
//  MagnificationGesture.swift
//  iOS Bootcamp
//
//  Created by Macuser on 23/10/2023.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State var zoomLevel: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                Circle().frame(width: 36, height: 32)
                Text("Mr. Anonymous")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 288)
                .scaleEffect(1 + zoomLevel)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            zoomLevel = value - 1
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                zoomLevel = 0
                            }
                        }
                )
            
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Text("This is the caption for my photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
