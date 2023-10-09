//
//  NavigationViewBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 20/09/2023.
//

import SwiftUI

struct NavigationViewBootcamp: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                
                ForEach(0..<15){ index in
                    NavigationLink( "Go to page #\(index)", destination: SecondScreen(title: "Page No #\(index)"))
                        .padding(.all)
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(false)
//            .navigationBarItems(
//                leading: HStack{
//                    NavigationLink(
//                        destination: SecondScreen(title: "Profile"), label: {
//                            Image(systemName: "person.fill")
//                        }
//                    ).accentColor(Color.black)
//                    NavigationLink(
//                        destination: SecondScreen(title: "Hot Items"), label: {
//                            Image(systemName: "flame.fill")
//                        }
//                    )                },
//                trailing: NavigationLink(destination: SecondScreen(title: "Wishlist"), label: {
//                    Image(systemName: "heart.fill")
//                        .renderingMode(.original)
//                })
//            )
        }
    }
}

struct NavigationViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewBootcamp()
    }
}

struct SecondScreen : View{
    
    @Environment(\.presentationMode) var presentationMode
    
    var title: String;
    
    var body: some View{
        ZStack{
            Color.yellow
                .ignoresSafeArea(.all)
                .navigationTitle("\(title)")
            
            VStack(spacing: 20){
                Button("<- Go Back to previous page"){
                    presentationMode.wrappedValue.dismiss()
                }
                
                NavigationLink("Go to Next Page ->", destination: SecondScreen(title: "Details"))
            }
        }
    }
}
