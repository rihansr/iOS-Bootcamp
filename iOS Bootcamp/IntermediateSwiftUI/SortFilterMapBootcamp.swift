//
//  SortFilterMapBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 26/10/2023.
//

import SwiftUI

struct SFMUserModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let surname: String?
    let scores: Int
    let isVerified: Bool
}

@MainActor
final class SortFilterMapViewModel: ObservableObject {
    @Published var dataArray:[SFMUserModel] = []
    @Published var filteredArray:[SFMUserModel] = []
    @Published var mappedArray:[String] = []
    @Published var selectedUser: String? = nil
    
    init(){
        getUsers()
        doSort()
        doCombine()
    }
    
    func getUsers(){
        dataArray = [
            SFMUserModel(name: "David", surname: "Joe", scores: 47, isVerified: false),
            SFMUserModel(name: "John", surname: "Doe", scores: 3, isVerified: true),
            SFMUserModel(name: "Richard", surname: nil, scores: 92, isVerified: false),
            SFMUserModel(name: "Amanda", surname: "Jolly", scores: 52, isVerified: true),
            SFMUserModel(name: "Subhan", surname: nil, scores: 120, isVerified: true),
            SFMUserModel(name: "Richie", surname: "Harvard", scores: 39, isVerified: false),
            SFMUserModel(name: "Sonam", surname: "Kapoor", scores: 20, isVerified: true),
            SFMUserModel(name: "Rizve", surname: "Rahman", scores: 300, isVerified: true),
            SFMUserModel(name: "Doe", surname: nil,  scores: 86, isVerified: false),
            SFMUserModel(name: "Hania", surname: "Amir", scores: 23, isVerified: false),
            SFMUserModel(name: "Rihan", surname: nil, scores: 0, isVerified: true),
        ]
    }
    
    /// Sorting
    /// ```
    /// dataArray.sorted(by: { (user1, user2) in
    ///     return user1.scores > user2.scores
    /// })
    /// ```
    func doSort(){
        filteredArray = dataArray.sorted(by: { $0.scores > $1.scores} )
    }
    
    /// Filtering
    /// ```
    /// dataArray.filter({ user in
    ///     return user.isVerified
    /// })
    /// ```
    func doFilter(){
        filteredArray = dataArray.filter({ $0.isVerified })
    }
    
    /// Mapping
    /// ```
    /// dataArray.map({ user in
    ///    return user.name
    /// })
    /// ```
    /// Will return only non-nullable item
    /// ```
    /// mappedArray = dataArray.compactMap({ user in
    ///     return user.surname
    /// })
    /// ```
    func doMap(){
        mappedArray = dataArray.map({ $0.name })
        // mappedArray = dataArray.compactMap({ $0.surname })
    }
    
    func doCombine(){
        mappedArray = dataArray
            .sorted(by: { $0.scores > $1.scores })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
    }
}

struct SortFilterMapBootcamp: View {
    
    @StateObject var viewmodel = SortFilterMapViewModel()
    
    var body: some View {
        ScrollView{
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(viewmodel.mappedArray, id: \.self){ name in
                        Text(name)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(.gray)
                            .onTapGesture {
                                viewmodel.selectedUser = name
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            ScrollViewReader{ proxy in
                VStack(spacing: 12){
                    ForEach(viewmodel.filteredArray){ user in
                        HStack{
                            VStack(alignment: .leading){
                                Text(user.name)
                                    .font(.headline)
                                Text("Score: \(user.scores)")
                                    .font(.caption)
                            }
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                        .id(user.name)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .onChange(of: viewmodel.selectedUser) { val in
                    withAnimation(.spring()){
                        proxy.scrollTo(val, anchor: .top)
                    }
                }
            }
        }
        .navigationBarTitle("Users")
    }
}

struct SortFilterMapBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SortFilterMapBootcamp()
        }
    }
}
