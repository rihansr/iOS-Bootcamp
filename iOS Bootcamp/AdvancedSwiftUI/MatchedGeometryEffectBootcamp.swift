//
//  MatchedGeometryEffectBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 08/11/2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack{
            if(!isClicked){
                RoundedRectangle(cornerRadius: 8)
                    .matchedGeometryEffect(id: "effect_id", in: namespace)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            isClicked.toggle()
                        }                    }
            }
            
            Spacer()
            
            if(isClicked){
                RoundedRectangle(cornerRadius: 12)
                    .matchedGeometryEffect(id: "effect_id", in: namespace)
                    .frame(width: 175, height: 175)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            isClicked.toggle()
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.yellow.ignoresSafeArea(edges: .horizontal))
    }
}

struct MatchedGeometryEffectTabBar: View {
    
    private var tabs: [String] = ["Home", "Profile", "Settings"]
    @State var selected: String = "Home"
    @Namespace private var namespace
    
    var body: some View {
        HStack(){
            ForEach(tabs, id: \.self) { tab in
                /*
                 ZStack{
                     if(selected == tab){
                         RoundedRectangle(cornerRadius: 4)
                             .fill(Color.gray.opacity(0.25))
                             .matchedGeometryEffect(id: "tab_id", in: namespace)
                     }

                     Text(tab)
                 }
                 */
                ZStack(alignment: .bottom){
                    if(selected == tab){
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.blue)
                            .matchedGeometryEffect(id: "tab_id", in: namespace)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }

                    Text(tab)
                        .foregroundColor(selected == tab ? .blue : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .onTapGesture {
                    withAnimation(.spring()){
                        selected = tab
                    }
                }
            }
        }
    }
}

struct MatchedGeometryEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectTabBar()
    }
}
