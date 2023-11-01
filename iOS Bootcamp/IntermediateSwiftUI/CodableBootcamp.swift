//
//  CodableBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 01/11/2023.
//

import SwiftUI

struct CustomerModel: Identifiable, Decodable, Encodable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, points, isPremium
    }
    
    init(id: String, name: String, points: Int, isPremium: Bool){
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.points, forKey: .points)
        try container.encode(self.isPremium, forKey: .isPremium)
    }
}

/*
 or
 */

struct CodableCustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    @Published var customer: CodableCustomerModel? = nil
    
    init(){
        getData()
    }
    
    func getData(){
        guard let data = getJsonData() else { return }
        customer = try? JSONDecoder().decode(CodableCustomerModel.self, from: data)
    }
    
    func getJsonData()-> Data?{
        let customer = CodableCustomerModel(id: "12873", name: "David Richard", points: 234, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        if let customer = vm.customer {
            VStack(spacing:16){
                Text("ID: " + customer.id)
                Text("Name: " + customer.name)
                Text("Points: \(customer.points)")
                Text("Premium: " + customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
