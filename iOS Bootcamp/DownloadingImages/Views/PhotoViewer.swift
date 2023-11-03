//
//  PhotoViewer.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import SwiftUI

struct PhotoViewer: View {
    @State var zoomLevel: CGFloat = 0
    var url: String
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String) {
        self.url = url
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url))
    }
    
    var body: some View {
        ZStack{
            if loader.isLoading {
                ProgressView()
            }
            else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1 + zoomLevel)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                zoomLevel = value - 1
                            }
                            .onEnded{ value in
                                withAnimation(.spring()){
                                    zoomLevel = 0
                                }
                            }
                    )
            }
            else {
                Rectangle()
            }
        }
            .navigationTitle("Image")
            .toolbar {
                ToolbarItem {
                    Button {
                        loader.download()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }

                }
            }
    }
}

struct PhotoViewer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PhotoViewer(url: "https://via.placeholder.com/600/92c952")
        }
    }
}
