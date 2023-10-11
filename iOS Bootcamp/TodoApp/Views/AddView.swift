//
//  AddView.swift
//  TodoList
//
//  Created by Macuser on 05/10/2023.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var taskViewModel: TaskViewModel
    @State private var texts: String = ""
    @FocusState private var autoFocus : Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing:16) {
                TextField("Type something here...", text: $texts)
                    .focused($autoFocus)
                    .padding(.horizontal)
                    .frame(height: 56)
                    .background(.gray.opacity(0.15))
                    .cornerRadius(8)
                    .submitLabel(.done)
                    .onSubmit {
                        addTask()
                    }
                    .onAppear{
                        autoFocus.toggle()
                    }
                
                Button(action: {}) {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth:.infinity)
                        .background(.blue)
                        .cornerRadius(8)
                        .onTapGesture {
                            addTask()
                        }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Add an Item")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func addTask(){
        if textIsAppropriate() {
            taskViewModel.add(title: texts)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if texts.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text("Your new todo item must be at least 3 characters long!!"))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddView()
        }
        .environmentObject(TaskViewModel())
    }
}

