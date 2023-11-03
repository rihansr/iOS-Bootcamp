//
//  PhotoModelDataService.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation
import Combine

class PhotoModelDataService{
    static let instance = PhotoModelDataService()
    
    @Published var photoModels:[PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    private init(){
        fetchData()
    }
    
    func fetchData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Fetching Error: \(error)")
                }
            } receiveValue: { [weak self] photoModels in
                self?.photoModels = photoModels
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
