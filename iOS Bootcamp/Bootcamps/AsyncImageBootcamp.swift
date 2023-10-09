//
//  AsyncImageBootcamp.swift
//  FirstIOSProject
//
//  Created by Macuser on 27/09/2023.
//

import SwiftUI

struct AsyncImageBootcamp: View {
    let url = URL(string: "https://picsum.photos/400")
    /// <#Description#>
    var body: some View {
        VStack{
            AsyncImage(url: url)
                .cornerRadius(30 )
            
            AsyncImage(url: url, content: {image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(25)
            }, placeholder: {
                ProgressView()
            })
            
            AsyncImage(url: url, content: {phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(25)
                case .failure:
                    Image(systemName: "questionmark")
                default:
                    Image(systemName: "questionmark")
                }
            })
        }
    }
}

struct AsyncImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageBootcamp()
    }
}
