//
//  IconWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 13/09/2023.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        Image("png_image")
            .renderingMode(.original)
        //.resizable()
            .font(.largeTitle)
            .aspectRatio(contentMode: .fit)
        //            .scaledToFit()
        //            .scaledToFill()
            .frame(width: .infinity, height: 200)
        //            .clipShape(
        //                Circle()
        //                //Rectangle()
        //                //RoundedRectangle(cornerRadius: 12)
        //                //Ellipse()
        //            )
            .cornerRadius(30)
        //            .clipped()
    }
}

struct ImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ImageBootcamp()
    }
}
