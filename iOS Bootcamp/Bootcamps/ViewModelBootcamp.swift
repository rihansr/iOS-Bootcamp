//
//  ViewModelBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 26/09/2023.
//

import SwiftUI

struct Fruit: Identifiable{
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    @Published var fruits : [Fruit] = []
    @Published var isLoading : Bool = false
    
    init(){
        getFruits()
    }
    
    func getFruits(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.fruits.append(Fruit(name: "Apple", count: 20))
            self.fruits.append(Fruit(name: "Orange", count: 3))
            self.fruits.append(Fruit(name: "Guava", count: 23))
            self.fruits.append(Fruit(name: "Pineaple", count: 20))
            self.isLoading = false
        })
    }
    
    func remove(indexSet: IndexSet){
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indexSet: IndexSet, index: Int){
        fruits.move(fromOffsets: indexSet, toOffset: index)
    }
}

struct ViewModelBootcamp: View {
    
    // @StateObject -> Use this on Creation / Init
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List{
                if fruitViewModel.isLoading{
                    ProgressView()
                }
                else {
                    ForEach(fruitViewModel.fruits){ fruit in
                        HStack{
                            Text("\(fruit.name)")
                                .font(.headline)
                                .bold()
                            Text("\(fruit.count)")
                                .foregroundColor(.red)
                        }
                    }
                    .onDelete(perform: fruitViewModel.remove)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing:
                    NavigationLink(
                        destination: RandomScreen(fruitViewModel: fruitViewModel),
                        label: {
                            Image(systemName: "arrow.right")
                        })
            )
        }
    }
}

struct RandomScreen: View {
    
    // @ObservedObject -> Use this for subviews
    @ObservedObject var fruitViewModel: FruitViewModel
    
    var body: some View{
        VStack{
            List{
                ForEach(fruitViewModel.fruits){ fruit in
                    Text(fruit.name)
                        .font(.headline)
                }

                .onMove(perform: fruitViewModel.move)
            }
        }
        .navigationBarItems(trailing: EditButton())
    }
}

struct ViewModelBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelBootcamp()
    }
}



