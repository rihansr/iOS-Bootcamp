//
//  PreferenceKeyBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 15/11/2023.
//

import SwiftUI

struct ScrollViewPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct PreferenceKeyBootcamp: View {
    
    @State private var scrollViewOffset: CGFloat = 0.0
    
    var body: some View {
        ScrollView{
            VStack{
                titleLayer
                    .opacity(Double(scrollViewOffset)/59)
                    .onScrollOffsetChnaged(action: {scrollViewOffset = $0})
                
                contentLayer
            }
        }
        .overlay(
            overlayLayer
                .opacity(scrollViewOffset < 16 ? 1.0 : 0.0),
            alignment: .top
        )
    }
}

struct PreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyBootcamp()
    }
}


extension PreferenceKeyBootcamp {
    private var titleLayer: some View {
        Text("New Title")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) {_ in
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 200)
                .padding(.horizontal)
        }
    }
    
    private var overlayLayer: some View {
        Text("\(scrollViewOffset)")
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(.yellow)
    }
}

extension View {
    func onScrollOffsetChnaged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader{ geo in
                Text("")
                    .preference(key: ScrollViewPreferenceKey.self,value: geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollViewPreferenceKey.self) {action($0)}
    }
}
