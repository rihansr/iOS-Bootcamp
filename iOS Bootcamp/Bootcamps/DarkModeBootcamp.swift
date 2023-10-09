//
//  DarkModeBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct DarkModeBootcamp: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            VStack(spacing: 32){
                Text("This color is PRIMARY")
                    .foregroundColor(.primary)
                Text("This color is SECONDARY")
                    .foregroundColor(.secondary)
                Text("This color is ACCENT")
                    .foregroundColor(.accentColor)
                Text("This color is RED")
                    .foregroundColor(.red)
                Text("This color is globaly adaptive")
                    .foregroundColor(Color("AdaptiveColor"))
                Text("This color is locally adaptive")
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
            .navigationTitle("Dark Mode")
        }
    }
}

struct DarkModeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            DarkModeBootcamp()
                .preferredColorScheme(.light)
            DarkModeBootcamp()
                .preferredColorScheme(.dark)
        }
    }
}
