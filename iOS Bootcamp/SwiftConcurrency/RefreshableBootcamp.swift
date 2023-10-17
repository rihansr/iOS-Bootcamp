//
//  RefreshableBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 17/10/2023.
//

import SwiftUI

class RefreshableDataManager{
    func getData() async throws -> [String]{
        do{
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return ["Apple", "Orange", "Mango", "Guava", "Pomegranate"].shuffled()
        } catch{
            throw error
        }
    }
}

class RefreshableBootcampViewModel: ObservableObject{
    @Published var fruits: [String] = []
    private let manager = RefreshableDataManager()
    
    func loadData() async {
        do {
            fruits = try await manager.getData()
        } catch {
            print(error)
        }
    }
}

struct RefreshableBootcamp: View {
    
    @StateObject var viewmodel = RefreshableBootcampViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(viewmodel.fruits, id: \.self){
                        Text($0)
                    }
                }
            }
            .refreshable {
                await viewmodel.loadData()
            }
            .task{
                await viewmodel.loadData()
            }
            .navigationTitle("Fruits")
        }
    }
}

struct RefreshableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableBootcamp()
    }
}
