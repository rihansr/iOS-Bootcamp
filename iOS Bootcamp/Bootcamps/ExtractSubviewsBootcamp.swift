//
//  ExtractedFunctionsBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 18/09/2023.
//

import SwiftUI

struct ExtractSubviewsBootcamp: View {
    
    @State var color: Color = Color.white
    
    var body: some View {
        ZStack{
            // Background
            Color.yellow.ignoresSafeArea(.all)
            
            // Foreground
            contentView
        }
    }
    
    var contentView: some View {
        VStack{
            Text("Here's some buttons down below\n↓")
                .font(.title3)
                .multilineTextAlignment(.center)
            HStack{
                CustomButton(title: "A", background: Color.black, color: Color.black)
                CustomButton(title: "B", background: Color.blue, color: Color.blue)
                CustomButton(title: "C", background: Color.red, color: Color.red)
            }
        }
    }
}

struct ExtractSubviewsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtractSubviewsBootcamp()
    }
}

struct CustomButton: View{
    
    let title: String
    let background: Color
    var color: Color
    @State var stateColor: Color
    
    init(title: String, background: Color, color: Color) {
        self.title = title
        self.background = background
        self.color = color
        self.stateColor = color
    }
    
    var body: some View{
        Button(action: {
            changeColor()
        }, label: {
            Text(title.capitalized)
                .font(.headline)
                .padding(.all)
                .foregroundColor(stateColor)
                .background(background)
                .shadow(radius: 10)
                .cornerRadius(8)
        })
    }
    
    
    func changeColor(){
        self.stateColor = (self.stateColor == Color.white) ? color : Color.white
    }
}
