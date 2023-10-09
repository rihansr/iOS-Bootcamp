//
//  SafeAreaInsetsBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

struct SafeAreaInsetsBootcamp: View {
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{}
            }
            .navigationTitle("Safe Area Insets")
            .navigationBarTitleDisplayMode(.inline)
            //            .safeAreaInset(edge: .top, alignment: .trailing, spacing: nil) {
            //                Text("Hi")
            //                    .frame(maxWidth: .infinity)
            //                    .background(Color.yellow.ignoresSafeArea())
            //            }
            .safeAreaInset(edge: .bottom, alignment: .trailing, spacing: nil) {
                Text("Hi")
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding()
            }
        }
    }
}

struct SafeAreaInsetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaInsetsBootcamp()
    }
}
