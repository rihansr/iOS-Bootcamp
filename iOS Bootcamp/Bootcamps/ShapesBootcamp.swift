//
//  ShapesWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 13/09/2023.
//

import SwiftUI

struct ShapesBootcamp: View {
    var body: some View {
        //        Circle()
        //        Capsule()
        //        Ellipse()
        Rectangle()
        //        RoundedRectangle(cornerRadius: 8)
            .trim(
                from: 0.1, to:0.9)
            .fill(
            //                Color(uiColor: UIColor.blue)
            //                LinearGradient(
            //                colors: [Color("ShadowColor"), Color.blue],
            //                startPoint: .leading,
            //                endPoint: .trailing)
            //                RadialGradient(
            //                    colors: [Color("ShadowColor"), Color.blue],
            //                    center: .topLeading,
            //                    startRadius: 25,
            //                    endRadius: 250)
                AngularGradient(
                    colors: [Color("ShadowColor"), Color.blue],
                    center: .center,
                    angle: .degrees(180))
            )
            .foregroundColor(Color("CustomColor"))
        //            .stroke(Color.blue, style: StrokeStyle(
        //            lineWidth: 10,
        //            lineCap: .round,
        //            dash: [20,30,30]
        //            ))
        //            .aspectRatio(1.0, contentMode: .fit)
            .shadow(color: Color("ShadowColor").opacity(0.6), radius: 10)
            .frame(width: 250, height: 250)
        
        
    }
}

struct ShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBootcamp()
    }
}
