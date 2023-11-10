//
//  GenericsBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 10/11/2023.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

struct GenericView<T:View>: View {
    let content: T
    let title: String
    
    var body: some View {
        VStack{
            content
            Text(title)
        }
    }
}

struct GenericsBootcamp: View {
    
    let stringModel: GenericModel<String> = GenericModel(info: "GenericModel Info")
    let boolModel: GenericModel<Bool> = GenericModel(info: false)
    
    var body: some View {
        VStack(spacing: 24){
            Text("Title")
             
            GenericView(
                content: Text("Generic Title"),
                title: "Params Title"
            )
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
