//
//  EnvironmentObjectBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 27/09/2023.
//

import SwiftUI

class EnvironmentViewModel : ObservableObject{
    @Published var dataArray: [String]  = []
    
    init(){
        getData()
    }
    
    func getData(){
        self.dataArray.append(contentsOf: ["iphone", "iPad", "iMac", "Apple Watch"])
    }
}

struct EnvironmentObjectBootcamp: View {
    
    @StateObject var environmentViewModel: EnvironmentViewModel = EnvironmentViewModel()
    var body: some View {
        NavigationView {
            List{
                ForEach(environmentViewModel.dataArray, id: \.self){ item in
                    NavigationLink {
                        DetailsView( selectedItem:item)
                    } label: {
                        Text(item)
                    }
                    
                }
            }
            .navigationTitle("iOS Devices")
        }
        .environmentObject(environmentViewModel)
    }
}

struct DetailsView : View{
    
    let selectedItem: String
    
    var body: some View{
        ZStack{
            
            // Background
            Color.yellow.ignoresSafeArea()
            
            // Foreground
            NavigationLink(destination: FinalView(), label: {
                Text(selectedItem)
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding()
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(30)
            })
        }
    }
}

struct FinalView : View{
    
    @EnvironmentObject var viewModel: EnvironmentViewModel
    
    var body: some View{
        ZStack{
            
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            // Foreground
            ScrollView{
                VStack(spacing: 20){
                    ForEach(viewModel.dataArray, id: \.self){ item in
                        Text(item)
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
        }
    }
}

struct EnvironmentObjectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectBootcamp()
    }
}

