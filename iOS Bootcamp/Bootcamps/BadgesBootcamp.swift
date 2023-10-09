//
//  BadgesBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 27/09/2023.
//

import SwiftUI

struct BadgesBootcamp: View {
    
    @State var index: Int = 3
    let cartItems: [String] = ["Apple", "Orange", "Guava"]
    
    var body: some View {
        TabView(selection: $index){
            Text("Profile".uppercased())
                .font(.title2)
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
            
            Text("Home".uppercased())
                .font(.title2)
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
                .badge("New")
            
            List{
                Text("Pineapple")
                    .badge("OFFER!!")
                ForEach(cartItems, id: \.self){
                    Text($0)
                        .badge(3)
                }
            }
            .tabItem{
                Image(systemName: "cart")
                Text("Cart")
            }
            .tag(3)
            .badge(3)
        }
    }
}

struct BadgesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BadgesBootcamp()
    }
}
