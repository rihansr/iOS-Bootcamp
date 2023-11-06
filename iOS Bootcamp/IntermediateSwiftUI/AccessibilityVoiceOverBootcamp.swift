//
//  AccessibilityVoiceOverBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 06/11/2023.
//

import SwiftUI

struct AccessibilityVoiceOverBootcamp: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack{
                        Text("Volume")
                        Spacer()
                        Text(isActive ? "TRUE" : "FALSE")
                            .accessibility(hidden: true)
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isActive ? "is ON" : "is OFF")
                    .accessibilityHint("Double tap to toggle setting.")
                    .accessibilityAction {
                        isActive.toggle()
                    }
                } header: {
                    Text("PREFERENCES")
                }
                Section {
                    Button("Favourites"){
                        
                    }
                    .accessibilityRemoveTraits(.isButton)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favourites")
                    
                    Text("Favourites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture {
                            
                        }
                } header: {
                    Text("APPLICATION")
                }
                
                VStack{
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:8){
                            ForEach(1..<6) { i in
                                VStack{
                                    Image("png_image")
                                        .resizable()
                                        .frame(width: 96, height: 96)
                                        .cornerRadius(10)
                                    Text("Item \(i)")
                                }
                                .onTapGesture {
                                    
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Item \(i). Image of office")
                                .accessibilityHint("Double tap to open.")
                                .accessibilityAction {}
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct AccessibilityVoiceOverBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityVoiceOverBootcamp()
    }
}
