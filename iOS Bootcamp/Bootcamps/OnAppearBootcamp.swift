//
//  OnAppearBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct OnAppearBootcamp: View {
    
    @State var status: String = ""
    @State var count: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView{
                Text(status)
                LazyVStack{
                    ForEach(0..<50){ _ in
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 200)
                            .onAppear {
                                count+=1
                            }
                    }
                }
            }
            .padding()
            .onAppear{
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 5,
                    execute: {
                        status = "ScrollView now appeared"
                    }
                )
            }
            .onDisappear{
                status = "ScrollView now disappeared"
            }
            .navigationTitle("On Appear: \(count)")
        }
    }
}

struct OnAppearBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        OnAppearBootcamp()
    }
}
