//
//  StacksWidget.swift
//  FirstIOSProject
//
//  Created by Macuser on 14/09/2023.
//

import SwiftUI

struct StacksBootcamp: View {
    let centerValue: Int
    var body: some View {
        VStack(){
            Text("Tic-Tac-Toe").font(.system(size: 24))
            Spacer(minLength: nil).frame(height: 20)
            HStack(){
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                
            }
            HStack(alignment: .center, spacing: 8){
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                ZStack(){
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    
                    Text("\(centerValue)")
                        .font(.system(size: 48))
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 100)
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                
            }
            HStack(){
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                
            }
        }
    }
}

struct StacksBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StacksBootcamp(centerValue: 1)
    }
}
