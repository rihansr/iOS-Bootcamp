//
//  FrameWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 14/09/2023.
//

import SwiftUI

enum Country: String {
    case bangladesh
    case japan
}

struct FrameBootcamp: View {
    let country: Country
    let background: Color
    
    init(country: Country) {
        self.country = country
        switch(country){
        case .bangladesh:
            self.background = Color.green
        case .japan:
            self.background = Color.white
        }
    }
    
    var body: some View {
        Text("\(country.rawValue)".capitalized)
            .font(.title2)
            .foregroundColor(background)
            .frame(width: 150, height:150)
            .background(Circle().fill(Color.red))
            .frame(maxWidth: .infinity, minHeight: 250)
            .clipShape(Rectangle())
            .background(background)
            .frame(maxHeight: .infinity)
            .padding(.all, 12)
            .background(Color("ShadowColor"))
    }
}

struct FrameBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FrameBootcamp(country: .bangladesh)
    }
}
