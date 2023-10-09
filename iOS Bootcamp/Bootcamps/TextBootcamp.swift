//
//  ContentView.swift
//  FirstIOSProject
//
//  Created by Macuser on 12/09/2023.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Aa")
            .textSelection(.enabled)
            .fontWeight(.black)
            .underline(true, color: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
            .foregroundColor(Color.red)
            .multilineTextAlignment(.trailing)
            .lineLimit(2)
            .strikethrough()
            .baselineOffset(100)
            .kerning(10)
            .frame(width: 100, height: 100)
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
