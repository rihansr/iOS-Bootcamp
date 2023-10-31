//
//  WeakSelfBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 31/10/2023.
//

import SwiftUI

class WeakSelfViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init(){
        print("INITIALIZE NOW!!")
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(count + 1, forKey: "count")
        getWeakSelfData()
    }
    
    func getWeakSelfData(){
        /*
         data = "New Data"
         */
        
        // We don't absolutely need this class to stay alive, so if this class
        // for whatever reason gets de-initialized it's okay and we can just
        // ignore whatever thess calls are
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){ [weak self] in
            self?.data = "New Data"
        }
    }
    
    func getStrongSelfData(){
        /*
         DispatchQueue.global().async {
             self.data = "New Data"
         }
         */
        
        // Class could not be de-initialized until this closure completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            // While this tasks are running, this self so this class absolutely
            // needs to stay because we need that self when we came back
            self.data = "New Data"
        }
    }
    
    deinit{
        print("DEINITIALIZE NOW!!")
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(count - 1, forKey: "count")
    }
}

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle("Screen #1")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .padding(.top, 24)
                .padding(.horizontal)
                .background(.red),
            alignment: .topTrailing)
        .ignoresSafeArea()
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var viewmodel = WeakSelfViewModel()
    
    var body: some View {
        VStack{
            Text("Screen #2")
                .font(.title)
            if let data = viewmodel.data {
                Text(data)
            }
        }
    }
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
