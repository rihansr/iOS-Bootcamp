//
//  RotationGestureBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 23/10/2023.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = Angle(degrees: 15)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .rotationEffect(angle)
            .gesture(
            RotationGesture()
                .onChanged{ value in
                    angle = value
                }
                .onEnded{ value in
                    withAnimation(.spring()){
                        angle = Angle(degrees: 0)
                    }
                }
            )
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}


