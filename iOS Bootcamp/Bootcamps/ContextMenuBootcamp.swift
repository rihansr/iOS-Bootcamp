//
//  ContextMenuBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 21/09/2023.
//

import SwiftUI

struct ContextMenuBootcamp: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            Image(systemName: "house.fill")
                .font(.title)
            Text("Swiftful Thinking")
                .font(.headline)
            Text("How to use Context Menu")
                .font(.subheadline)
        }
        .foregroundColor(Color.white)
        .padding(30)
        .background(Color.blue.cornerRadius(30))
        .contextMenu {
            Button(action: {}, label: {
                Label("Share", systemImage: "square.and.arrow.up")
            })
            Button(action: {}, label: {
                Label("Report", systemImage: "option")
            })
            Button(action: {}, label: {
                Label("Like", systemImage: "heart")
            })
        }
    }
}

struct ContextMenuBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuBootcamp()
    }
}
