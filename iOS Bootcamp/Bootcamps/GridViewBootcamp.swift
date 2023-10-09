//
//  GridViewWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 15/09/2023.
//

import SwiftUI

struct GridViewBootcamp: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing:0.5, alignment: nil),
        GridItem(.flexible(), spacing: 0.5, alignment: nil),
        GridItem(.flexible(), spacing: 0.5, alignment: nil)
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 0.5,
                pinnedViews: [.sectionHeaders],
                content: {
                    Section(
                        header: Text("Section 1")
                            .foregroundColor(Color.white).frame(maxWidth: .infinity, minHeight: 48)
                            .background(Color.blue),
                        content: {
                            ForEach(0..<12, content: {
                                index in Rectangle().frame(height: 120)
                            })
                        }
                    )
                    Section(
                        header: Text("Section 2")
                            .foregroundColor(Color.white).frame(maxWidth: .infinity, minHeight: 48)
                            .background(Color.green),
                        content: {
                            ForEach(0..<10, content: {
                                index in Rectangle().frame(height: 120)
                            })
                        }
                    )
                    Section(
                        header: Text("Section 2")
                            .foregroundColor(Color.white).frame(maxWidth: .infinity, minHeight: 48)
                            .background(Color.red),
                        content: {
                            ForEach(0..<24, content: {
                                index in Rectangle().frame(height: 120)
                            })
                        }
                    )
                    
                })
        }
    }
}

struct GridViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GridViewBootcamp()
    }
}
