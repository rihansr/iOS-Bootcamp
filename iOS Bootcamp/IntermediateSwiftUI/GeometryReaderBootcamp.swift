//
//  GeometryReaderBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 24/10/2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(0..<20){ i in
                    GeometryReader{ proxy in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: proxy) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
        /*
         GeometryReader{ proxy in
             HStack(spacing:0){
                 Rectangle()
                     .fill(.red)
                     .frame(width: proxy.size.width * 0.75)
                 Rectangle()
                     .fill(.blue)
             }
             .ignoresSafeArea()
         }
         */
    }
    
    func getPercentage(geo: GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
