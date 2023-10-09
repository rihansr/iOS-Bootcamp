//
//  AnimationTimingBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 19/09/2023.
//

import SwiftUI

struct AnimationTimingBootcamp: View {
    @State var isAnimating: Bool = false
    let timing: Double = 2.0
    
    var body: some View {
        VStack{
            Button("Press Me!!"){
                isAnimating.toggle()
            }
            Item(isAnimating : isAnimating, animation: Animation.default)
            Item(isAnimating : isAnimating, animation: .spring(
                response: 0.5,
                dampingFraction: 0.7,
                blendDuration: 1.0
            ))
            Item(isAnimating : isAnimating, animation: Animation.linear(duration: timing))
            Item(isAnimating : isAnimating, animation: Animation.easeIn(duration: timing))
            Item(isAnimating : isAnimating, animation: Animation.easeInOut(duration: timing))
            Item(isAnimating : isAnimating, animation: Animation.easeIn(duration: timing))
        }
    }
    
}

struct AnimationTimingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTimingBootcamp()
    }
}


struct Item : View {
    let isAnimating: Bool
    let animation: Animation
    var body: some View{
        RoundedRectangle(cornerRadius: 20)
            .frame(width: isAnimating ? 300 : 50, height: 100)
            .animation(animation, value: isAnimating)
    }
}
