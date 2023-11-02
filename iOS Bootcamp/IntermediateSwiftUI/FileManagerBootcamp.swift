//
//  FileManagerBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 02/11/2023.
//

import SwiftUI
class LocalFileManager{
    static var instance = LocalFileManager()
    private let customFolder = "Bootcamp Assets"
    
    init(){
        createFolder()
    }
    
    func createFolder(){
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(customFolder).path else {
            print("\(customFolder) folder not created!!")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("\(customFolder) folder created successfuly!!")
            } catch let error {
                print("\(customFolder) folder creation error: \(error)")
            }
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let url = buildPath(name: name) else {
            return "Image not saved!!"
        }
        
        do {
            try data.write(to: url)
            return "Saved!!"
        } catch let error {
            print ("Image saving error: \(error)")
            return "Image not saved!!"
        }
    }
    
    func fetchImage(name: String) -> UIImage?{
        guard
            let path = buildPath(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Image not found!!")
            return nil
        }
        
        print("Image found!!")
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard let path = buildPath(name: name)?.path else {
            return "Image not found!!"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Deleted!!"
        } catch let error {
            print ("Image deletion error: \(error)")
            return "Image not deleted!!"
        }
    }
    
    func deleteFolder(){
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(customFolder).path else {
            print("\(customFolder) folder not deleted!!")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default.removeItem(atPath: path)
                print("\(customFolder) folder deleted successfuly!!")
            } catch let error {
                print("\(customFolder) folder deletion error: \(error)")
            }
        }
    }
    
    private func buildPath(name: String) -> URL?{
        /*
         let directory1 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
         let directory3 = FileManager.default.temporaryDirectory
         print(directory1, directory2, directory3)
         
         let path = directory1.first?
             .appendingPathComponent(customFolder)
             .appendingPathComponent(name + extensions)
         print(path)
         */
        
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(customFolder)
                .appendingPathComponent(name) else {
            print("Path not found")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    private let imageName: String =  "png_image.jpg"
    @Published var status: String =  ""
    @Published var isPlaceholder: Bool = false
    private let manager = LocalFileManager.instance
    
    init(){
        loadImage()
    }
    
    func loadImage(){
        if let image = manager.fetchImage(name: imageName){
            isPlaceholder = false
            self.image = image
        }
        else {
            loadAssetImage()
        }
    }
    
    func loadAssetImage(){
        isPlaceholder = true
        image = UIImage(named: imageName)
    }
    
    func savePhoto(){
        guard let image = image else { return }
        status = manager.saveImage(image: image, name: imageName)
        loadImage()
    }
    
    func deletePhoto(){
        status = manager.deleteImage(name: imageName)
        manager.deleteFolder()
        loadAssetImage()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack(spacing:2){
                    if let image = vm.image {
                        uiImage(image)
                            .overlay{
                                if vm.isPlaceholder{ placeholderLabel() }
                            }
                    }
                    HStack(spacing:0){
                        Button(
                            action: vm.savePhoto,
                            label: { buttonLabel("Save").background(.blue) }
                        )
                        Button(
                            action: vm.deletePhoto,
                            label: { buttonLabel("Delete").background(.red) }
                        )
                    }
                }
                .padding(.all, 8)
                .background(.white)
                .shadow(color: Color.gray.opacity(0.25), radius: 12)
                .rotationEffect(Angle(degrees: -5))
                .padding(.horizontal, 28)
                
                statusLabel(vm.status)
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}

extension FileManagerBootcamp {
    func uiImage(_ image: UIImage) -> some View{
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, alignment: .center)
            .clipped()
            .overlay{
                if vm.isPlaceholder{ placeholderLabel() }
            }
    }
    
    func placeholderLabel() -> some View {
        Text("Placeholder".uppercased())
            .foregroundColor(.red)
            .font(.system(size: 36, weight: .black, design: .rounded))
            .opacity(0.5)
            .rotationEffect(Angle(degrees: -40))
    }
    
    func buttonLabel(_ label: String) -> some View {
        Text(label.uppercased())
            .font(.headline)
            .fontDesign(.rounded)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
    }
    
    func statusLabel(_ label: String) -> some View {
        Text(label.uppercased())
            .font(.headline)
            .fontWeight(.light)
            .rotationEffect(Angle(degrees: -5))
            .padding(.leading, 36)
    }
}
