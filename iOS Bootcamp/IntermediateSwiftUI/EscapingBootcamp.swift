//
//  EscapingBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 31/10/2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData(){
        /*
         let newData = download1()
         text = newData
         */
        
        /*
         download2 { newData in
             self.text = newData
         }
         */
        
        /*
         download3 { newData in
             self.text = newData
         }
         */
        
        /*
         download4 { resultModel in
             self.text = resultModel.data
         }
         */
        
        download5 { result in
            self.text = result.data
        }
    }
    
    func download1() -> String{
        "New Data!!"
    }
    
    func download2(completionHandler: (_ data: String) -> Void) {
            completionHandler("New Data!!")
            }
    
    func download3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completionHandler("New Data!!")
        }
    }
    
    func download4(completionHandler: @escaping (DownloadResultModel) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completionHandler(DownloadResultModel(data: "New Data!!"))
        }
    }
    
    func download5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            completionHandler(DownloadResultModel(data: "New Data!!"))
        }
    }
}

typealias DownloadCompletion = (DownloadResultModel) -> ()

struct DownloadResultModel{
    let data: String
}

struct EscapingBootcamp: View {
    
    @StateObject var viewmodel = EscapingViewModel()
    
    var body: some View {
        Button(viewmodel.text){
            viewmodel.getData()
        }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
