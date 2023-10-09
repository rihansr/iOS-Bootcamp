//
//  TabViewBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct TabViewBootcamp: View {
    
    @State var index: String = "B"
    
    var body: some View {
        TabView(selection: $index){
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag("A")
            
            HomeView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag("B")
            
            SettingsView(tab: $index)
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag("C")
        }
        .accentColor(.red)
    }
}

struct ProfileView: View{
    var body: some View{
        Text("Profile")
    }
}

struct HomeView: View{
    
    let icons: [String] = [
        "heart.fill", "house.fill", "globe", "person.fill"
    ]
    
    var body: some View{
        TabView{
            ForEach(icons, id: \.self){ icon in
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .frame(height: 250)
        .background(Color.gray)
        .cornerRadius(16)
        .padding()
        .tabViewStyle(PageTabViewStyle())
    }
}

struct SettingsView: View{
    
    @Binding var tab: String
    
    var body: some View{
        VStack{
            Text("Settings")
            Button("Go to Profile"){
                tab = "A"
            }
        }
    }
}

struct TabViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewBootcamp()
    }
}

