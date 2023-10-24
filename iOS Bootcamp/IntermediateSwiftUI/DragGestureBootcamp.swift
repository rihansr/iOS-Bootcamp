//
//  DragGestureBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 24/10/2023.
//

import SwiftUI

struct DragGestureDragBootcamp: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                currentOffsetY = value.translation.height
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                let centerOffsetY = UIScreen.main.bounds.height/4
                                if currentOffsetY < -centerOffsetY{
                                    endingOffsetY = -startingOffsetY
                                }
                                else if endingOffsetY != 0 && currentOffsetY > centerOffsetY
                                {
                                    endingOffsetY = 0
                                }
                                currentOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct SignUpView: View {
    var body: some View{
        VStack(spacing:20){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("This is the description for our app. ")
                .multilineTextAlignment(.center)
            Text("Create an account ".uppercased())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.black)
                .cornerRadius(8)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .cornerRadius(32)
    }
}

struct DragGestureSwipeBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 500)
            .offset(offset)
            .scaleEffect(getScale())
            .rotationEffect(Angle(degrees: getRotation()))
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation(.spring()){
                            offset = value.translation
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.easeInOut){
                            offset = CGSize(width: 0, height: 0)
                        }
                    }
            )
    }
    
    func getScale() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let curAmount = abs(offset.width)
        let percentage = curAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotation() -> Double{
        let max = UIScreen.main.bounds.width / 2
        let curAmount = offset.width
        let percentage = curAmount / max
        let percentageDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageDouble * maxAngle
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureDragBootcamp()
    }
}
