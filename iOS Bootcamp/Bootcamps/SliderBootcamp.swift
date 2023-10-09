//
//  SliderBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct SliderBootcamp: View {
    @State var rating : Double = 3
    @State var color : Color = .green

    var body: some View {
        VStack(spacing: 48) {
            VStack{
                Text("RATING")
                Text(String(format: "%.1f", rating))
                    .font(.title)
            }
            Slider(value: $rating)
                .accentColor(.orange)
            
            Slider(value: $rating, in: 1...5)
                .accentColor(.yellow)
            
            Slider(value: $rating,
                   in: 1...5,
                   step: 0.5
            )
            
            Slider(value: $rating,
                   in: 1...5,
                   step: 1.0,
                   onEditingChanged: { (_) in
                color = rating < 3 ? .red : .green
            },
                   minimumValueLabel: Text("1"),
                   maximumValueLabel: Text("5"),
                   label: {
                Text("Rating")
            }
            )
            .accentColor(color)
        }
        .padding()
    }
}

struct SliderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SliderBootcamp()
    }
}
