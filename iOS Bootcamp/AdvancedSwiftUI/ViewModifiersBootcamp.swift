//
//  ViewModifiersBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 06/11/2023.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(8)
            .shadow(radius: 4)
    }
}

extension View {
    func withDefaultButtonViewModifier(background: Color = .blue) -> some View {
        modifier(
            DefaultButtonViewModifier(background: background)
        )
    }
}

struct ViewModifiersBootcamp: View {
    var body: some View {
        VStack(spacing:16){
            Text("Hello, Everyone")
                .font(.headline)
                .withDefaultButtonViewModifier(background: .green)
            Text("Hi, Guys!!")
                .font(.subheadline)
                .modifier(DefaultButtonViewModifier(background: .orange))
            Text("Hey, Dude!!")
                .font(.title)
                .modifier(DefaultButtonViewModifier(background: .red))
        }
        .padding()
    }
}

struct ViewModifiersBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifiersBootcamp()
    }
}
