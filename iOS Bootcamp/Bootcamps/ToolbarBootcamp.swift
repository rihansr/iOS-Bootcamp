//
//  ToolbarBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 28/09/2023.
//

import SwiftUI

struct ToolbarBootcamp: View {
    
    @State private var stackPath: [String] = []
    
    var body: some View {
        NavigationStack(path: $stackPath){
            ZStack{
                Color.white.ignoresSafeArea()
                ScrollView{
                    ForEach(0..<50){ index in
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 96)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(16)
                            .padding(.vertical, 6)
                            .padding(.horizontal)
                            .overlay{
                                Text("\(index)")
                            }
                            .shadow(radius: 2)
                    }
                }
            }
            .navigationTitle("Toolbar")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .toolbarBackground(.automatic, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar{
                //ToolbarItem(placement: .principal) {
                //    Button("Title"){}
                //}
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "heart.fill")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gear")
                }
                ToolbarItem(placement: .bottomBar) {
                    Image(systemName: "house.fill")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("CanA"){}
                }
                ToolbarItem(placement: .status) {
                    Button("Status"){}
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("ConA"){}
                }
                ToolbarItem(placement: .keyboard) {
                    Button("Keyboard"){}
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("PA"){}
                }
                ToolbarItem(placement: .secondaryAction) {
                    Button("SA"){}
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button("DA"){}
                }
            }
            .toolbarTitleMenu {
                Button("Screen #1"){
                    stackPath.append("Screen #1")
                }
                Button("Screen #2"){
                    stackPath.append("Screen #2")
                }
            }
            .navigationDestination(for: String.self){ val in
                Text(val)
                    .font(.title)
            }
        }
    }
}

struct ToolbarBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarBootcamp()
    }
}
