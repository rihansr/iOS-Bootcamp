//
//  BackgroundThreadBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 31/10/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            let data = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            // Before we update the data array we will go back on to the main thread
            DispatchQueue.main.async {
                self.dataArray = data
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    func downloadData() -> [String]{
        var data:[String] = []
        
        for i in 0..<100{
            data.append("\(i)")
            print(data)
        }
        
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var viewmodel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10){
                Button("Load Data"){
                    viewmodel.fetchData()
                }
                ForEach(viewmodel.dataArray, id: \.self){
                    Text($0)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View{
        BackgroundThreadBootcamp()
    }
}
