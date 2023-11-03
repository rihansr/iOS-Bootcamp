//
//  ImageLoadingViewModel.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation
import Combine
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var cacheManager = PhotoModelCacheManager<UIImage>()
    private var fileManager = PhotoModelFileManager.instance
    
    let url: String
    
    init(_ url: String){
        self.url = url
        loadImage()
    }
    
    func loadImage(){
        if let image = cacheManager.find(by: url){
            self.image = image
        }
        else {
            downloadImage()
        }
    }
    
    func download(){
        guard let image = image,
              let name = url.components(separatedBy: "/").last
        else { return }
        fileManager.save(image, by: name + ".png")
    }
    
    func downloadImage(){
        isLoading = true
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            /*
             .map { (data: Data, response: URLResponse) in
                 return UIImage(data: data)
             }
             */
            .receive(on: DispatchQueue.main)
            .map { UIImage(data: $0.data) }
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard
                    let self = self,
                    let image = image else { return }
                self.cacheManager.save(image, by: self.url)
                self.image = image
            }
            .store(in: &cancellables)
    }
}
