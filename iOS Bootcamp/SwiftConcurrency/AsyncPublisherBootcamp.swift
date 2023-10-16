import SwiftUI
import Combine

class AsyncPublisherDataManager {
    @Published var data: [String] = []
    
    func getData() async{
        data.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Pineapple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Guava")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Pomegranate")
    }
}

class AsyncPublisherViewModel: ObservableObject {
    @MainActor @Published var fruits: [String] = []
    private var manager: AsyncPublisherDataManager = AsyncPublisherDataManager()
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        Task{
            for await data in manager.$data.values {
                await MainActor.run {
                    self.fruits = data
                }
            }
        }
        
       /*
        manager.$data
            .receive(on: DispatchQueue.main)
            .sink{ data in
                self.fruits = data
            }
            .store(in: &cancellables)
        */
    }
    
    func start() async{
       await manager.getData()
    }
}

struct AsyncPublisherBootcamp: View {
    
    @StateObject var viewmodel: AsyncPublisherViewModel = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewmodel.fruits, id: \.self) {
                    Text($0)
                }
            }
        }
        .task {
            await viewmodel.start()
        }
    }
}

struct AsyncPublisherBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisherBootcamp()
    }
}
