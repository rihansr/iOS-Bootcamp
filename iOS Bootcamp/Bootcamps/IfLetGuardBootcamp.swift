//
//  IfLetGuardBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 25/09/2023.
//

import SwiftUI

struct IfLetGuardBootcamp: View {
    
    @State var isLoading : Bool = false
    @State var displayText : String? = nil
    @State var currentUserID : String? = "nil"
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Here we are practicing safe coding!")
                
                if let text = displayText{
                    Text(text)
                }
                
                Text(displayText ?? "")
                
                if isLoading{
                    ProgressView()
                }
                
                Spacer()
            }
            .navigationTitle("Safe Coding")
            .onAppear{
                loadData2()
            }
        }
    }
    
    func loadData1(){
        if let userID = currentUserID{
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                displayText = "This is the new data! User ID is: \(userID)"
                isLoading = false
            }
        }
        else{
            displayText = "Error!! There is no User ID"
        }
    }
    
    func loadData2(){
        guard let userID = currentUserID else {
            displayText = "Error!! There is no User ID"
            return
        }
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            displayText = "This is the new data! User ID is: \(userID)"
            isLoading = false
        }
    }
}

struct IfLetGuardBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IfLetGuardBootcamp()
    }
}
