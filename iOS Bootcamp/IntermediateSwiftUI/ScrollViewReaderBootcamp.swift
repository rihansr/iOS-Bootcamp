//
//  ScrollViewReaderBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 24/10/2023.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var indexText: String = ""
    
    var body: some View {
        VStack{
            TextField("Enter number...", text: $indexText)
                .padding()
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            Button("Scroll".uppercased()){
                if let index = Int(indexText){
                    scrollToIndex = index
                    indexText = ""
                }
            }
            ScrollView{
                ScrollViewReader{ proxy in
                    /*
                     Button("Scroll".uppercased()){
                         withAnimation(.spring()){
                             proxy.scrollTo(30, anchor: .bottom)
                         }
                     }
                     */
                    ForEach(0..<50){
                        Text("This is item: #\($0)")
                            .font(.headline)
                            .padding()
                            .frame(height: 192)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .padding(.horizontal)
                            .id($0)
                    }
                    .onChange(of: scrollToIndex) { index in
                        withAnimation(.spring()){
                            proxy.scrollTo(index, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
