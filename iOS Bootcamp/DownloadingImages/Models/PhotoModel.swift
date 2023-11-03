//
//  PhotoModel.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID =  "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
