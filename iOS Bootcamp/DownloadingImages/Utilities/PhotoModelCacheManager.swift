//
//  PhotoModelCacheManager.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager<T: NSObject> {
    
    var photoCache: NSCache<NSString, T> = {
        var cache = NSCache<NSString, T>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200MB
        return cache
    }()
    
    func save(_ image: T, by key: String){
        photoCache.setObject(image, forKey: key as NSString)
    }
    
    func find(by key: String) -> T?{
        photoCache.object(forKey: key as NSString)
    }
    
    func remove(by key: String){
        photoCache.removeObject(forKey: key as NSString)
    }
}
