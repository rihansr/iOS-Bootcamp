//
//  HashableBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 25/10/2023.
//

import SwiftUI

struct IdentifiableModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

struct HashableModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        //hasher.combine(title + subtitle)
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    let identifiableData: [IdentifiableModel] = [
        IdentifiableModel(title: "One"),
        IdentifiableModel(title: "Two"),
        IdentifiableModel(title: "Three"),
    ]
    
    let hashableData: [HashableModel] = [
        HashableModel(title: "Four"),
        HashableModel(title: "Five"),
        HashableModel(title: "Six"),
    ]
    
    var body: some View {
        VStack(spacing: 20){
            ForEach(identifiableData){ Text($0.title) }
            Divider()
            ForEach(hashableData, id: \.self){ Text($0.title) }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
