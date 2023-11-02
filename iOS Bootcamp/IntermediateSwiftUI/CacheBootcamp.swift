//
//  CacheBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 02/11/2023.
//

import SwiftUI

class CacheManager{
    static var instance = CacheManager()
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100MB
        return cache
    }()
    
    func save(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Saved!!"
    }
    
    func fetch(name: String) -> UIImage?{
        return imageCache.object(forKey: name as NSString)
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Cleared!!"
    }
}

class CacheViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    private let imageName: String =  "png_image.jpg"
    @Published var status: String =  ""
    @Published var isFromCache: Bool = false
    private let manager = CacheManager.instance
    
    init(){
        loadImage()
    }
    
    func loadImage(){
        if let image = manager.fetch(name: imageName){
            isFromCache = true
            self.image = image
        }
        else {
            loadAssetImage()
        }
    }
    
    func loadAssetImage(){
        isFromCache = false
        image = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = image else { return }
        status = manager.save(image: image, name: imageName)
        loadImage()
    }
    
    func removeFromCache(){
        status = manager.remove(name: imageName)
        loadAssetImage()
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack(spacing:2){
                    if let image = vm.image {
                        uiImage(image)
                            .overlay{
                                if vm.isFromCache{ cacheLabel() }
                            }
                    }
                    HStack(spacing:0){
                        Button(
                            action: vm.saveToCache,
                            label: { buttonLabel("Save").background(.blue) }
                        )
                        Button(
                            action: vm.removeFromCache,
                            label: { buttonLabel("Remove").background(.red) }
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
            .navigationTitle("Cache Manager")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}

extension CacheBootcamp {
    func uiImage(_ image: UIImage) -> some View{
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, alignment: .center)
            .clipped()
    }
    
    func cacheLabel() -> some View {
        Text("Cache".uppercased())
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
