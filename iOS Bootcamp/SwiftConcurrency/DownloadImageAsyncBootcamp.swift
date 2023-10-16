import SwiftUI
import Combine

class DownloadImageAsyncManager{
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            return nil
        }
        
        return image
    }
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            let image = self.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    // import Combine
    func downLoadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage?{
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch  {
            throw error
        }
    }
    
    func downloadUsingThrowingContinuation() async throws -> UIImage? {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let image = self.handleResponse(data: data, response: response) {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func downloadUsingContinuation() async -> UIImage? {
        return await withCheckedContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let _ = error,
                    let image = self.handleResponse(data: data, response: response) else
                {
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: image)
            }
        })
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data){
                return image
            }
            else {
                throw URLError(.badURL)
            }
        } catch  {
            throw error
        }
    }
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage()
        async let fetchImage2 = fetchImage()
        
        let (img1, img2, img3, img4) = await (
            try fetchImage1,
            try fetchImage2,
            try fetchImage(),
            try fetchImage()
        )
        
        return [img1, img2, img3, img4]
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        return try await withThrowingTaskGroup(of: UIImage?.self){ group in
            var images: [UIImage] = []
            images.reserveCapacity(4)
            
            group.addTask {
                try? await self.fetchImage()
            }
            
            group.addTask {
                try? await self.fetchImage()
            }
            
            group.addTask {
                try? await self.fetchImage()
            }
            
            group.addTask {
                try? await self.fetchImage()
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject{
    @Published var images: [UIImage] = []
    
    var cancellables = Set<AnyCancellable>()
    let manager: DownloadImageAsyncManager = DownloadImageAsyncManager()
    
    func fetchImage() async {
        /*
         manager.downloadWithEscaping { image, error in
         if let image = image {
         DispatchQueue.main.async {
         self.images.append(image)
         }
         }
         }
         */
        
        /*
         manager.downLoadWithCombine()
         .receive(on: DispatchQueue.main)
         .sink { _ in
         
         } receiveValue: { [weak self] image in
         if let image = image {
         self.images.append(image)
         }
         }
         .store(in: &cancellables)
         */
        
        /*
         let image = await manager.downloadUsingContinuation()
         if let image = image {
         await MainActor.run {
         self.images.append(image)
         }
         }
         */
        
        let image = try? await manager.downloadUsingThrowingContinuation()
        if let image = image {
            await MainActor.run {
                self.images.append(image)
            }
        }
    }
    
    func fetchImages() async {
        if let images = try? await manager.fetchImagesWithTaskGroup(){
            DispatchQueue.main.async {
                self.images.append(contentsOf: images)
            }
        }
    }
}

struct DownloadImageAsyncMain: View {
    var body: some View {
        NavigationView {
            ZStack{
                NavigationLink("View all photos ->") {
                    DownloadImageAsyncBootcamp()
                }
            }
            .navigationTitle("Photos")
        }
    }
}

struct DownloadImageAsyncBootcamp: View {
    
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 0)]
    
    @StateObject private var viewmodel = DownloadImageAsyncViewModel()
    
    @State private var task: Task<(), Never>? = nil
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 1){
                ForEach(viewmodel.images, id: \.self){ image in
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear{
            // Do single task
            /*
             task = Task(priority: .low) {
             await viewmodel.fetchImage()
             if let image = manager.image {
             images.append(image)
             }
             }
             */
            
            // Do all tasks at the same time
            /*
             Task(priority: .high){
             print("HIGH & Piority: \(Task.currentPriority)")
             await viewmodel.fetchImage()
             }
             Task(priority: .userInitiated){
             print("USER-INITIATED & Piority: \(Task.currentPriority)")
             await viewmodel.fetchImage()
             }
             Task(priority: .medium){
             print("MEDIUM & Piority: \(Task.currentPriority)")
             await viewmodel.fetchImage()
             }
             Task(priority: .low){
             print("LOW & Piority: \(Task.currentPriority)")
             await viewmodel.fetchImage()
             }
             Task(priority: .background){
             print("BACKGROUND & Piority: \(Task.currentPriority)")
             await viewmodel.fetchImage()
             }
             */
            
            // Execute after completed all tasks
            Task{
                await viewmodel.fetchImage()
            }
        }
        .onDisappear{
            task?.cancel()
        }
        .task {
            // try? Task.sleep(nanoseconds: 2_000_000_000)
            // await Task.yield()
            // await manager.fetchImage()
        }
    }
}

struct DownloadImageAsyncBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsyncMain()
    }
}
