//
//  NavigationStackBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

struct NavigationStackBootcamp: View {
    
    let fruits: [String] = ["Apple", "Orange", "Mango", "Guava"]
    
    @State private var stackPath: [String] = []
    
    var body: some View {
        //NavigationStack(path: $stackPath)
        NavigationStack{
            ScrollView{
                VStack(spacing: 32){
                    Button("Super segue!"){
                        //stackPath.append("Cocunut")
                        stackPath.append(contentsOf: [
                            "Coconut", "Pineapple", "Watermelon"
                        ])
                    }
                    
                    ForEach(fruits, id: \.self){ fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    
                    ForEach(0..<10){ val in
                        NavigationLink(value: val) {
                            Text("Click Me #\(val)")
                        }
                    }
                }
            }
            .navigationTitle("Navigation Stack")
            .navigationDestination(for: Int.self){ val in
                Text("Page #\(val)")
                    .font(.title)
            }
            .navigationDestination(for: String.self){ val in
                Text(val)
                    .font(.title)
            }
        }
    }
}

struct NavigationStackBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootcamp()
    }
}
