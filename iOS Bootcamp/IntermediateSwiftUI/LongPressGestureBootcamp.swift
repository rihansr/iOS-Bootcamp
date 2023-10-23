//
//  LongPressGestureBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 23/10/2023.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isPressing: Bool = false
    @State var isCompleted: Bool = false
    
    var body: some View {
        VStack{
            Rectangle()
                .fill()
                .frame(maxWidth:  isPressing ? .infinity : 0)
                .frame(height: 48)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack{
                Text("Press")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 48){ isPressing in
                            if(isPressing){
                                withAnimation(.easeInOut(duration: 1.0)){
                                    self.isPressing.toggle()
                                }
                            }
                            else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    if(!isCompleted){
                                        withAnimation(.easeInOut){
                                            self.isPressing = false
                                        }
                                    }
                                }
                            }
                    } perform: {
                        withAnimation(.easeInOut){
                            isCompleted = true
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 24) {
                        withAnimation(.easeInOut){
                            isCompleted = false
                            isPressing = false
                        }
                    }
            }
        }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
