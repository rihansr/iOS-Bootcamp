//
//  PhotoModelFileManager.swift
//  iOS Bootcamp
//
//  Created by Macuser on 03/11/2023.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static var instance = PhotoModelFileManager()
    private let customFolder = "Bootcamp Assets"
    
    init(){
        createFolder()
    }
    
    func createFolder(){
        guard let folder = buildFolderPath() else {
            print("\(customFolder) folder not created!!")
            return
        }
        
        if !FileManager.default.fileExists(atPath: folder.path){
            do {
                try FileManager.default.createDirectory(atPath: folder.path, withIntermediateDirectories: true)
                print("\(customFolder) folder created successfuly!!")
            } catch let error {
                print("\(customFolder) folder creation error: \(error)")
            }
        }
    }
    
    func save(_ image: UIImage, by name: String) {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let url = buildPath(name: name) else {
            print("Image not saved!!")
            return
        }
        
        do {
            try data.write(to: url)
            print("Saved!!")
        } catch let error {
            print ("Image saving error: \(error)")
        }
    }
    
    func find(by key: String) -> UIImage?{
        guard
            let path = buildPath(name: key)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("\(key) not found!!")
            return nil
        }
        
        print("\(key) found!!")
        return UIImage(contentsOfFile: path)
    }
    
    func delete(by key: String) -> String {
        guard let path = buildPath(name: key)?.path else {
            return "\(key) not found!!"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Deleted!!"
        } catch let error {
            print ("Image deletion error: \(error)")
            return "\(key) not deleted!!"
        }
    }
    
    func deleteFolder(){
        guard let folder = buildFolderPath() else {
            print("\(customFolder) folder not deleted!!")
            return
        }
        
        if !FileManager.default.fileExists(atPath: folder.path){
            do {
                try FileManager.default.removeItem(atPath: folder.path)
                print("\(customFolder) folder deleted successfuly!!")
            } catch let error {
                print("\(customFolder) folder deletion error: \(error)")
            }
        }
    }
    
    private func buildPath(name: String) -> URL?{
        guard let folder = buildFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(name)
    }
    
    private func buildFolderPath() -> URL?{
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(customFolder)
                else {
            return nil
        }
        return path
    }
}
