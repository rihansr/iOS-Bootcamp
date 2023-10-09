//
//  CustomModelBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 26/09/2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let email: String
    let followers: Int
    let verified: Bool
}

struct CustomModelBootcamp: View {
    
    let users: [UserModel] = [
        UserModel(name: "Nick Jonas", email: "mr@gmail.com", followers: 12, verified: false),
        UserModel(name: "Emily Enderson", email: "emily@gmail.com", followers: 1242, verified: true),
        UserModel(name: "Rihan S R", email: "rihan@yahoo.com", followers: 345, verified: false),
        UserModel(name: "Chris Brown", email: "chris@hotmail.com", followers: 809, verified: true),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users){ user in
                    HStack(spacing: 12 ){
                        Circle()
                            .frame(width: 42, height: 42)
                        VStack(alignment: .leading, spacing: 4){
                            HStack{
                                Text(user.name)
                                    .font(.headline)
                                if user.verified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            Text(user.email)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(spacing: 4){
                            Text("\(user.followers)")
                                .font(.headline)
                            Text("Followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Users")
        }
    }
}

struct CustomModelBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomModelBootcamp()
    }
}


