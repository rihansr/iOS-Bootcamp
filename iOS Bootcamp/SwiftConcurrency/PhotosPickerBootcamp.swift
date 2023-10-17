import SwiftUI
import PhotosUI

@MainActor
final class PhotosPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet { setImage(from: imageSelection) }
    }
    
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet { setImages(from: imageSelections) }
    }
    
    func setImage(from selection: PhotosPickerItem? ) {
        guard let selection else { return }
        Task{
            do{
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data,
                      let image = UIImage(data: data) else{
                    throw URLError(.badServerResponse)
                }
                self.selectedImage = image
            }
            catch{
                print(error)
            }
        }
    }
    
    func setImages(from selections: [PhotosPickerItem]){
        Task{
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self),
                   let image = UIImage(data: data){
                    images.append(image)
                }
            }
            selectedImages = images
        }
    }
}

struct PhotosPickerBootcamp: View {
    
    @StateObject private var viewmodel = PhotosPickerViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            if let image = viewmodel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            }
            
            PhotosPicker(selection: $viewmodel.imageSelection, matching: .images) {
                Text("Select Photo ->")
            }
            
            if !viewmodel.selectedImages.isEmpty {
                ScrollView(.horizontal, showsIndicators: true){
                    HStack(alignment: .center) {
                        ForEach(viewmodel.selectedImages, id: \.self) {
                            Image(uiImage: $0)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(2.5)
                        }
                    }
                }
            }
            
            PhotosPicker(selection: $viewmodel.imageSelections, matching: .any(of: [.images, .screenshots])) {
                Text("Pick Photos ->")
            }
        }
        .padding()
    }
}

struct PhotosPickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerBootcamp()
    }
}
