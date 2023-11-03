//
//  DownloadingImagesBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                    ForEach(vm.photos) { model in
                        NavigationLink {
                            PhotoViewer(url: model.url)
                        } label: {
                            PhotoItemView(photo: model)
                        }

                    }
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
