//
//  ActionSheetBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 21/09/2023.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    
    @State var showActionSheet: Bool = false
    var body: some View {
        Button("Click me"){
            showActionSheet.toggle()
        }
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(
                title: Text("This is title"),
                message: Text("This is message"),
                buttons: [
                    .default(Text("Add")),
                    .destructive(Text("Edit")),
                    .cancel()
                ]
            )
        })
    }
}

struct ActionSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetBootcamp()
    }
}
