//
//  DownlodingImagesViewModel.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    @Published var photos:[PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()
    private let dataService = PhotoModelDataService.instance

    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .dropFirst()
            .sink { [weak self] photos in
                self?.photos = photos
            }
            .store(in: &cancellables)
    }
}
