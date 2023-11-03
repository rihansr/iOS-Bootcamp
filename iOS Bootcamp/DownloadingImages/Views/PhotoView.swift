//
//  PhotoView.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import SwiftUI

struct PhotoView: View {
    
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String){
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
                    .clipShape(Circle())
            }
            else {
                Circle()
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(url: "https://via.placeholder.com/150/92c95")
            .frame(width: 64, height: 64, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
