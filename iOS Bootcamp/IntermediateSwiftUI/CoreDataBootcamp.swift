//
//  CoreDataBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 26/10/2023.
//

import SwiftUI
import CoreData

final class CoreDataViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var fruits: [FruitEntity] = []
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        fetch()
    }
    
    func fetch(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            fruits = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func add(){
        guard !name.isEmpty else {return}
        
        let item = FruitEntity(context: container.viewContext)
        item.name = self.name
        
        save()
        name = ""
    }
    
    func update(item: FruitEntity){
        item.name = (item.name ?? "") + "!"
        
        save()
    }
    
    func delete(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let item = fruits[index]
        container.viewContext.delete(item)
        
        save()
    }
    
    func save() {
        do {
            try container.viewContext.save()
            fetch()
        } catch let error {
            print("Data Saving Error: \(error.localizedDescription)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var viewmodel = CoreDataViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("Type here...", text: $viewmodel.name)
                        .font(.headline)
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                        .background(.gray.opacity(0.15))
                        .cornerRadius(8)
                        .onSubmit {
                            viewmodel.add()
                        }
                    
                    Button{
                        viewmodel.add()
                    } label: {
                        Text("Add")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }.padding(.horizontal)
                List{
                    ForEach(viewmodel.fruits) { item in
                        Text(item.name ?? "")
                            .onTapGesture {
                                viewmodel.update(item: item)
                            }
                    }
                    .onDelete(perform: viewmodel.delete)
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarItems(trailing: EditButton())
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
