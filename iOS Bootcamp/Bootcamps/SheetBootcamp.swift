//
//  SheetsBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 19/09/2023.
//

import SwiftUI

struct SheetBootcamp: View {
    
    @State var showSheet: Bool = false
    @State var selectedDetent: PresentationDetent = .medium
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea(.all)
            Button("Please, Open Sheet!!"){
                showSheet.toggle()
            }
            .font(.title2)
            //            .fullScreenCover(
            //                isPresented: $showSheet,
            //                content: { SheetView()}
            //            )
            .sheet(
                isPresented: $showSheet,
                onDismiss: {},
                content: {
                    SheetView(selectedDetent: $selectedDetent)
                        .presentationDragIndicator(.visible)
                    //.presentationDetents([.medium, .large])
                    //.presentationDetents([.fraction(0.2), .medium])
                    //.presentationDetents([.height(100), .medium])
                        .presentationDetents([.fraction(0.4), .medium, .large], selection: $selectedDetent)
                        .interactiveDismissDisabled()
                }
            )
            
//            SheetView()
//                .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
//                .animation(.spring())
        }
        
    }
}

struct SheetView : View {
    
    @Binding var selectedDetent: PresentationDetent
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack()
        {
            Color.yellow.ignoresSafeArea(.all)
            
            VStack(spacing:48){
                Button("40%".uppercased()){
                    selectedDetent = .fraction(0.4)
                }
                Button("Medium".uppercased()){
                    selectedDetent = .medium
                }
                Button("Large".uppercased()){
                    selectedDetent = .large
                }
                Button("Dismiss".uppercased()){
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
    }
}


struct SheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SheetBootcamp()
    }
}

/*
 struct SheetBootcamp_Previews: PreviewProvider {
     @State static var selectedDetent:PresentationDetent = .medium

     static var previews: some View {
         SheetView(selectedDetent: $selectedDetent)
     }
 }
*/
