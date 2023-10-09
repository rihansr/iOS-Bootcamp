//
//  DocumentationBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct DocumentationBootcamp: View {
    
    // MARK: PROPERTIES
    let fruits: [String] = ["Orange", "Apple", "Grapes", "Guava"]
    @State var showAlert: Bool = false
    
    // MARK: BODY
    
    // Single line comment
    
    /*
     Multiple line comment
     - Code Folding Command
     opt + cmd + <
     */
    var body: some View {
        NavigationView {
            foregroundLayer
                .navigationTitle("Documentation")
                .navigationBarItems(trailing: Button("Alert"){
                    showAlert.toggle()
                })
                .alert(isPresented: $showAlert, content: {
                    // Documentation popup command => opt + left click
                    getAlert(text: "This is an alert!!")
                })
        }
    }
    
    /// This is the foreground layer that holds a scrollview
    var foregroundLayer: some View{
        ScrollView {
            ForEach(fruits, id: \.self) { fruit in
                Text("\(fruit)")
                    .padding()
            }
        }
    }
    
    // MARK: FUNCTIONS
    
    /// Gets an alert with a specified title.
    ///
    /// This function creates and returns an alert immediately. Ther alert will have a title base on the text parameter but it will not have a message
    ///```
    ///getAlert(text: "Hi") -> Alert(title: Text("Hi"))
    ///```
    /// - Warning: There is no additional message in this alert
    /// - Parameter text: This is the title for alert.
    /// - Returns: Returns an alert with a title.
    func getAlert(text: String) -> Alert{
        return Alert(title: Text(text))
    }
}

// MARK: PREVIEW
struct DocumentationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationBootcamp()
    }
}
