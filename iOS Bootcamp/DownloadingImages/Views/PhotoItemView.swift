//
//  PhotoItemView.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import SwiftUI

struct PhotoItemView: View {
    
    let photo: PhotoModel
    
    var body: some View {
        HStack{
            PhotoView(url: photo.thumbnailURL)
                .frame(width: 64, height: 64, alignment: .center)
            VStack(alignment: .leading, spacing: 8){
                Text(photo.title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(photo.url)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

struct PhotoItemView_Previews: PreviewProvider {
    private static let model = PhotoModel(
        albumID: 1,
        id: 1,
        title: "accusamus beatae ad facilis cum similique qui sunt",
        url: "https://via.placeholder.com/600/92c952",
        thumbnailURL: "https://via.placeholder.com/150/92c952"
    )
    static var previews: some View {
        PhotoItemView(photo: model)
            .previewLayout(.sizeThatFits)
    }
}
