//
//  ToggleBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 21/09/2023.
//

import SwiftUI

struct ToggleBootcamp: View {
    
    @State var toggleIsOn: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Status:")
                    .font(.headline)
                Text((toggleIsOn ? "Online" : "Offline").uppercased())
            }
            .font(.title2)
            
            Toggle("Active Status", isOn: $toggleIsOn)
                .toggleStyle(SwitchToggleStyle(tint: .red))
        }
        .padding(.all)
    }
}

struct ToggleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToggleBootcamp()
    }
}
