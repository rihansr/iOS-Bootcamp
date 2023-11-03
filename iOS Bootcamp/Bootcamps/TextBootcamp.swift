//
//  ContentView.swift
//  FirstIOSProject
//
//  Created by Macuser on 12/09/2023.
//

import SwiftUI

struct TextBootcamp: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack{
            Text("Aa")
                .textSelection(.enabled)
                .fontWeight(.black)
                .underline(true, color: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .foregroundColor(Color.red)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
                .strikethrough()
                .baselineOffset(100)
                .kerning(10)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Image(systemName: "heart.fill")
                    Text("Welcome to Bootcamp")
                        .truncationMode(.tail)
                }
                .font(.title)
                
                Text("This is some longer text expands to multiple lines.")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                    //.minimumScaleFactor(sizeCategory == .extraExtraExtraLarge ? 0.8 : 1.0)
                    .minimumScaleFactor(sizeCategory.customMinScaleFactor)
            }
            .padding()
            .background(.red)
        }
    }
}

extension ContentSizeCategory {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraLarge:
            return 6.0
        default:
            return 0.85
        }
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
