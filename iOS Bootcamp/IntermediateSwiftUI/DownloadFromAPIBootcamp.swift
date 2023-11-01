//
//  DownloadWithEscapingBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 01/11/2023.
//

import SwiftUI
import Combine

typealias Handler = (_ data: Data?) -> ()
actor DownloadFromAPIManager{
    func fetchData(endpoint url: String = "", completionHandler: @escaping Handler) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
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

class DownloadFromAPIViewModel: ObservableObject{
    @Published var posts: [PostModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var manager = DownloadFromAPIManager()
    
    init(){
        let endpoint = "https://jsonplaceholder.typicode.com/posts"
        // getDataUsingEscaping(url: endpoint)
        getDataUsingCombine(url: endpoint)
    }
    
    func getDataUsingEscaping(url: String){
        Task{
            await manager.fetchData(
                endpoint: url,
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
    
    func getDataUsingCombine(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time!
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // optional
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            // .replaceError(with: []) //default data
            // .sink(receiveValue: { [weak self] posts in
            //    self?.posts = posts
            // })
            .sink { (completion) in
                print("Completion: \(completion)")
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
}

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id:Int
    let title: String
    let body: String
}

struct DownloadFromAPIBootcamp: View {
    
    @StateObject var vm = DownloadFromAPIViewModel()
    
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

struct DownloadFromAPIBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadFromAPIBootcamp()
    }
}
