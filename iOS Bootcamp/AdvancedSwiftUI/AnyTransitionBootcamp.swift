//
//  AnyTransitionBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 08/11/2023.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        //return AnyTransition.modifier(
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        //return AnyTransition.modifier(
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    
    static var rotateOn: AnyTransition {
        //return AnyTransition.asymmetric(
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

struct AnyTransitionBootcamp: View {
    
    @State var showRectangle: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            
            if(showRectangle){
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.transition(AnyTransition.move(edge: .leading))
                    //.transition(AnyTransition.scale.animation(.easeInOut))
                    //.modifier(RotateViewModifier(rotation: 180))
                    //.transition(AnyTransition.rotating.animation(.easeInOut))
                    //.transition(.rotating(rotation: 1080))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click Me!")
                .withDefaultButtonViewModifier()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct AnyTransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionBootcamp()
    }
}
