//
//  ListBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 20/09/2023.
//

import SwiftUI

struct ListBootcamp: View {
    
    @State var fruits: [String] = ["Apple", "Orange", "Banana", "Guava", "Pineapple"]
    
    @State var veggies: [String] = ["Tomatoo", "Potato", "Carrot"]
    
    var body: some View {
        NavigationView{
            List {
                Section(
                    header:
                        HStack{
                            Text("Fruits")
                            Image(systemName: "flame.fill")
                        }
                        .font(.caption)
                        .foregroundColor(Color.orange)
                ){
                    ForEach(fruits, id: \.self){ fruit in
                        Text(fruit.capitalized)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.yellow)
                    .listRowSeparatorTint(Color.white)
                }
                Section(
                    header: Text("Veggies")
                ){
                    ForEach(veggies, id: \.self){
                        Text($0.capitalized)
                            .swipeActions(
                                edge:.leading,
                                allowsFullSwipe: true) {
                                    Button("Share"){}
                                        .tint(.blue)
                                }
                                .swipeActions(
                                    edge: .trailing,
                                    allowsFullSwipe: false) {
                                        Button("Delete"){}
                                            .tint(.red)
                                        Button("Draft"){}
                                            .tint(.gray)
                                        Button("Edit"){}
                                            .tint(.green)
                                    }
                    }
                }
            }
            //.listStyle(DefaultListStyle())
            //.listStyle(GroupedListStyle())
            //.listStyle(InsetGroupedListStyle())
            //.listStyle(SidebarListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Add", action: add)
            )
        }
        .accentColor(Color.red)
    }
    
    func delete(indexSet: IndexSet){
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, destination: Int){
        fruits.move(fromOffsets: indices, toOffset: destination)
    }
    
    func add(){
        fruits.append("Licchi")
    }
}

struct ListBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcamp()
    }
}

