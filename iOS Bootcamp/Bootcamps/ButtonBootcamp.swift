//
//  ButtonBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 18/09/2023.
//

import SwiftUI

struct ButtonBootcamp: View {
    @State var title: String = "This is my title"
    var body: some View {
        
        VStack(spacing: 32){
            Text(title)
            
            Button("Press Me!"){
                self.title = "Button #1 Pressed"
            }
            
            Button("I'm Plain, Press Me!"){
                self.title = "Button #1.1 Pressed"
            }
            .buttonStyle(.plain)
            
            Button("I'm borderd, ress Me!"){
                self.title = "Button #1.2 Pressed"
            }
            .controlSize(.large)
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            
            Button("I'm borderedProminent, Press Me!"){
                self.title = "Button #1.3 Pressed"
            }
            .buttonStyle(.borderedProminent)
            
            Button("I'm borderless, Press Me!"){
                self.title = "Button #1.4 Pressed"
            }
            .buttonStyle(.borderless)
            
            Button(action: {
                self.title = "Button #2 Pressed"
            }, label: {
                Text("Save")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(
                        Color.blue
                            .cornerRadius(8)
                            .shadow(radius: 8)
                    )
            })
            
            Button(action: {
                self.title = "Button #3 Pressed"
            }, label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 72, height: 72)
                    .shadow(radius: 10)
                    .overlay {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.red)
                    }
            })
            
            Button(action: {
                self.title = "Button #4 Pressed"
            }, label: {
                Text("Finish".uppercased())
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color.gray)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .stroke(Color.gray, lineWidth: 1))
            })
            
            Text("Tap")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
                .padding(.horizontal, 20)
                .background(
                    Color.red
                        .cornerRadius(8)
                        .shadow(radius: 8)
                )
                .onTapGesture {
                    self.title = "Button #5 Tapped"
                }
            //                .onTapGesture(count: 2){
            //                    self.title = "Button #6 Tapped"
            //                }
            
        }
    }
}

struct ButtonBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBootcamp()
    }
}
