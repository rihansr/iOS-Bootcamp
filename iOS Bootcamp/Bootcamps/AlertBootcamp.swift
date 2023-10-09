//
//  AlertBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 21/09/2023.
//

import SwiftUI

struct AlertBootcamp: View {
    @State var showALert: Bool = false
    @State var background: Color = Color.yellow
    
    var body: some View {
        ZStack{
            background.ignoresSafeArea(.all)
            Button("Click Me!!"){
                showALert.toggle()
            }
            .alert(
                isPresented: $showALert,
                content: {
                    //                    Alert(title: Text("There was an error!"))
                    getAlert()
                })
        }
    }
    
    func getAlert() ->  Alert{
        return Alert(
            title: Text("This is title!"),
            message: Text("This is message"),
            primaryButton: .destructive(Text("Delete")){
                background = .orange
            },
            secondaryButton: .cancel()
        )
    }
}

struct AlertBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp()
    }
}
