//
//  SafeAreaBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 18/09/2023.
//

import SwiftUI

struct SafeAreaBootcamp: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("List of 100 digits:").frame(maxWidth: .infinity, alignment: .leading).padding(.all, 16)
                ForEach(0..<101, content: {index in
                    Text("\(index)").padding(.all, 20)
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.secondary.ignoresSafeArea(edges: .all)
        )
    }
}

struct SafeAreaBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaBootcamp()
    }
}
