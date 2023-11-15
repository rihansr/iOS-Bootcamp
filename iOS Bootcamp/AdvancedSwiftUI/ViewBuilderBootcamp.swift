//
//  ViewBuilderBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 15/11/2023.
//

import SwiftUI

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, content: Content) {
        self.title = title
        self.content = content
    }
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View{
        CustomVStack{
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 4)
                .frame(height: 1)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct CustomVStack<Content:View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading){
            content
        }
    }
}

struct CustomStack<Content:View>: View {
    enum StackType{
        case hStack, vStack, zStack
    }
    
    let stack: StackType
    let content: Content
    
    init(stack: StackType, @ViewBuilder content: () -> Content){
        self.stack = stack
        self.content = content()
    }
    
    var body: some View{
        stackView
    }
    
    @ViewBuilder private var stackView: some View {
        switch(stack){
        case .hStack: hStackView
        case .vStack: vStackView
        case .zStack: zStackView
        }
    }
    
    private var hStackView: some View {
        HStack{
            content
        }
    }
    private var vStackView:  some View {
        VStack{
            content
        }
    }
    private var zStackView:  some View {
        ZStack{
            content
        }
    }
}


struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack{
            HeaderViewGeneric(title: "Title"){
                VStack {
                    Text("New Subtitle")
                }
            }
            CustomStack(stack: .vStack) {
                Text("a")
                Text("b")
            }
        }
    }
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderBootcamp()
    }
}
