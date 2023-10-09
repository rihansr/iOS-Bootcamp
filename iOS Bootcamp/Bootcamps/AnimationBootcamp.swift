//
//  AnimationBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 19/09/2023.
//

import SwiftUI

struct AnimationBootcamp: View {
    @State var isAnimated: Bool = true
    
    var body: some View {
        VStack(spacing: 16){
                        
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.orange : Color.yellow)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 300 : 0))
                .offset(y: isAnimated ? 300: 0)
            //                .animation(.default)
                .onTapGesture {
                    withAnimation(.default) {
                        isAnimated.toggle()
                    }
                }
            
        }
    }
}

struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootcamp()
    }
}
