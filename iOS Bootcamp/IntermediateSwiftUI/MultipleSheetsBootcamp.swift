//
//  MultipleSheetsBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 24/10/2023.
//

import SwiftUI

struct SheetModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: SheetModel? = nil
    
    /// Using a binding
    // @State var showSheet: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach(0..<20){ index in
                    Button("ITEM #\(index)"){
                        self.selectedModel = SheetModel(title: "ITEM #\(index)")
                        /// Using a binding
                        // self.showSheet.toggle()
                    }
                    .padding()
                }
            }
        }
        /// Using a $item
        .sheet(item: $selectedModel) { model in
            MultipleSheetView(model: model)
                .presentationDragIndicator(.visible)
                .presentationDetents([ .medium, .large])
        }
        /// Using a binding
        /*
         .sheet(isPresented: $showSheet) {
             MultipleSheetView(model: $selectedModel)
         }
         */
    }
}

struct MultipleSheetView: View {
    
    let model: SheetModel
    
    /// Using a binding
    //@Binding var model: SheetModel?
    
    var body: some View{
        ZStack {
            Color.yellow.ignoresSafeArea(.all)
            
            Text(model.title)
                .font(.largeTitle)
        }
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
