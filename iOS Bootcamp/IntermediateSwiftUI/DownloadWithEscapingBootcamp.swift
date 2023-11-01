//
//  DownloadWithEscapingBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 01/11/2023.
//

import SwiftUI

typealias Handler = (_ data: Data?) -> ()
actor DownloadWithEscapingManager{
    func fetchData(endpoint url: String = "", completionHandler: @escaping Handler) {
        guard let url = URL(string: url) else {
            return completionHandler(nil)
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid Response")
                completionHandler(nil)
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status Code: \(response.statusCode)")
                completionHandler(nil)
                return
            }
            
            if let data = data {
                let jsonString = String(data: data, encoding: .utf8)
                print("Data: \(String(describing: jsonString))")
                completionHandler(data)
            }
            else {
                print("No Data")
                completionHandler(nil)
            }
        }
        .resume()
    }
}

class DownloadWithEscapingViewModel: ObservableObject{
    @Published var posts: [PostModel] = []
    private var manager = DownloadWithEscapingManager()
    
    init(){
        getData()
    }
    
    func getData(){
        Task{
            await manager.fetchData(
                endpoint:
                    "https://jsonplaceholder.typicode.com/posts",
                completionHandler: {
                    if let data =  $0,
                       let posts = try? JSONDecoder().decode([PostModel].self, from: data)
                    {
                        DispatchQueue.main.async { [weak self] in
                            self?.posts = posts
                        }
                    }
                })
        }
    }
}

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id:Int
    let title: String
    let body: String
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(vm.posts){post in
                    VStack(alignment: .leading, spacing: 8){
                        Text(post.title)
                        Text(post.body)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Posts")
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
