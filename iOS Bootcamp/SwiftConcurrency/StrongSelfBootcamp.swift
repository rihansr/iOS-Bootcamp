import SwiftUI

class StrongSelfDataService{
    
    /// Return data after two minutes
    func getData() async -> String {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return "Updated Data!!"
    }
    
}

class StrongSelfBootcampViewModel: ObservableObject {
    @Published var title: String = "Some Title!!"
    let service = StrongSelfDataService()
    private var task: Task<Void, Never>? = nil
    private var tasks: [Task<Void, Never>] = []
    
    /// This implies a strong reference
    func updateData(){
        /*
         Task{
         title = await service.getData()
         }
         */
        
        Task{
            self.title = await self.service.getData()
        }
        
        /*
         Task{ [self] in
         self.title = await self.service.getData()
         }
         */
    }
    
    /// This implies a weak reference
    func updateData1(){
        /*
         weak self: If this class want to deallocate thats totally fine because here this is a weak reference now, this is saying that if when this code comes back if the class is still in memory, we'll handle the response but if its is deallocated for whatever reason that is okay with us because if it's deallocated it's probably deallocated for a reason we propably don't even need to run these functions anymore
         */
        Task{ [weak self] in
            if let title = await self?.service.getData(){
                self?.title = title
            }
        }
    }
    
    /// We don't need to manage weak/strong
    /// We can manage the Task!
    func updateData2(){
        task = Task{
            self.title = await self.service.getData()
        }
    }
    
    /// We can manage the Tasks!
    func updateData3(){
        let task1 = Task{
            self.title = await self.service.getData()
        }
        tasks.append(task1)
        
        let task2 = Task{
            self.title = await self.service.getData()
        }
        tasks.append(task2)
    }
    
    /// We purposely do not cancel tasks to keep strong references
    func updateData4(){
        Task{
            self.title = await self.service.getData()
        }
        
        Task.detached{
            self.title = await self.service.getData()
        }
    }
    
    func updateData5() async {
        self.title = await self.service.getData()
    }
    
    func cancelTask() {
        task?.cancel()
        task = nil
        
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

struct StrongSelfBootcamp: View {
    
    @StateObject var viewmodel = StrongSelfBootcampViewModel()
    
    var body: some View {
        Text(viewmodel.title)
            .font(.headline)
            .onAppear{
                viewmodel.updateData()
            }
            .onDisappear{
                viewmodel.cancelTask()
            }
            .task {
                await viewmodel.updateData5()
            }
    }
}

struct StrongSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StrongSelfBootcamp()
    }
}
