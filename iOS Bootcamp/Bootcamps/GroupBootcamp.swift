//
//  GroupBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

struct GroupBootcamp: View {
    var body: some View {
        VStack (spacing:48){
            Text("Hello World!")
            Group{
                Text("Hello World!")
                Text("Hello World!")
            }
            .font(.title3)
            .foregroundColor(.green)
        }
        .font(.title)
        .foregroundColor(.red)
    }
}

struct GroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GroupBootcamp()
    }
}
