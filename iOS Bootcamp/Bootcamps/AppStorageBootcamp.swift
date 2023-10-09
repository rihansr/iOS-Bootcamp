//
//  AppStorageBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 27/09/2023.
//

import SwiftUI

struct AppStorageBootcamp: View {
    
    //@State var currentName: String?
    @AppStorage("name") var currentName: String?
    
    var body: some View {
        VStack(spacing: 16){
            Text(currentName ?? "Add name here")
            Button("Save".uppercased()){
                let name = "Emily Endarson"
                currentName = name
                //UserDefaults.standard.set(name, forKey: "name")
            }
        }
        .font(.title2)
        /*
         .onAppear{
         currentName = UserDefaults.standard.string(forKey: "name")
         }
         */
    }
}

struct AppStorageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageBootcamp()
    }
}
