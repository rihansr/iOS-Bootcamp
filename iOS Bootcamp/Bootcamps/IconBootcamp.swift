//
//  IconWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 14/09/2023.
//

import SwiftUI

struct IconBootcamp: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .renderingMode(.template)
        //.resizable()
            .font(.system(size: 40))
            .aspectRatio(contentMode: .fit)
        //            .scaledToFit()
        //            .scaledToFill()
            .foregroundColor(Color.red)
            .background(
                Circle().fill(
                    LinearGradient(
                        colors: [Color.blue, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    
                )
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(
                            width: 32, height: 32, alignment: .center)
                        .overlay(
                            Text("1")
                                .font(.headline)
                                .foregroundColor(Color.red)
                        ),
                    
                    alignment: .bottomTrailing
                )
                .frame(width: 100, height: 100)
            )
            .shadow(radius: 8, x: 0.0, y: 10)
        //            .frame(width: .infinity, height: 200)
        //            .clipped()
    }
}

struct IconBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconBootcamp()
    }
}
