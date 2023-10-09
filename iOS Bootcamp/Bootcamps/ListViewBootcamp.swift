//
//  ScrollViewWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 15/09/2023.
//

import SwiftUI

struct ListViewBootcamp: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false,  content: {
            LazyVStack{
                ForEach(0..<10) { i in
                    ScrollView(.horizontal, showsIndicators: false
                    ){
                        LazyHStack{
                            ForEach(1..<10){ j in
                                Text("\(i)\(j)").font(.title)
                                    .frame(width: 100, height:  100)
                                    .background(Color.yellow)
                                
                            }
                        }
                    }
                }
            }
        })
    }
}

struct ListViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListViewBootcamp()
    }
}
