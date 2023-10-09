//
//  TransitionAnimationBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 19/09/2023.
//

import SwiftUI

struct TransitionAnimationBootcamp: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Button("Press Me!!"){
                showView.toggle()
            }
            
            //              TransitionView(showView: $showView)
            //                .frame(height: UIScreen.main.bounds.height * 0.5)
            //                .opacity(showView ? 1.0 : 0.0)
            //                .animation(.easeInOut)
            
            if showView {
                TransitionView(showView: $showView)
                    .transition(
                        AnyTransition.move(edge: .bottom)
                        //                        .asymmetric(
                        //                            insertion: .move(edge: .bottom),
                        //                            removal: AnyTransition.opacity.animation(.easeInOut) 
                        //                        )
                    )
                //                    .transition(AnyTransition.scale.animation(.easeInOut))
                //                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .animation(.easeInOut, value: showView)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
}

struct TransitionAnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TransitionAnimationBootcamp()
    }
}

struct TransitionView : View {
    
    @Binding var showView: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing)
        {
            Color.yellow.ignoresSafeArea(.all)
            Button(action: {
                showView.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.black)
                    .font(.title)
                    .padding(20)
            })
        }
    }
}
