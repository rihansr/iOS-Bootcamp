//
//  TypealiasBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 31/10/2023.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let rating: Double
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    // @State var item:MovieModel = MovieModel(title: "ttttt", director: "ddddd", rating: 3.5)
    
    @State var item:TVModel = TVModel(title: "ttttt", director: "ddddd", rating: 3.5)
    
    var body: some View {
        VStack(spacing: 10){
            Text(item.title)
            Text(item.director)
            Text(String(format: "%.1f", item.rating))
        }
    }
}

struct TypealiasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBootcamp()
    }
}
