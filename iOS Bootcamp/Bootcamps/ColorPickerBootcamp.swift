//
//  ColorPickerBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 22/09/2023.
//

import SwiftUI

struct ColorPickerBootcamp: View {
    
    @State var background: Color = Color.yellow
    
    var body: some View {
        background.edgesIgnoringSafeArea(.all)
            .overlay{
                VStack{
                    ColorPicker(
                        "Color".uppercased(),
                        selection: $background,
                        supportsOpacity: true
                    )
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(background)
                }
                .padding()
                .background(Capsule())
                .padding(.horizontal)
            }
    }
}

struct ColorPickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerBootcamp()
    }
}
