import SwiftUI

class MyManagerClass{
    func getData() async throws -> String {
        do{
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return "Clicked!!"
        } catch{
            throw error
        }
    }
}

actor MyManagerActor{
    func getData() async throws -> String {
        do{
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return "Clicked ;)"
        } catch{
            throw error
        }
    }
}

@MainActor
final class MVVMBootcampViewModel: ObservableObject {
    let managerClsss = MyManagerClass()
    let managerActor = MyManagerActor()
    
    /* @MainActor */ @Published private(set) var title: String = "Click Me!!"
    
    private var tasks: [Task<Void, Never>] = []
    
    /* @MainActor */
    func handleAction(){
        let task = Task { /* @MainActor in */
            do{
                // title =  try await managerClass.getData()
                title =  try await managerActor.getData()
            } catch{
                print(error)
            }
        }
        tasks.append(task)
    }
    
    func cancelTask() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}

struct MVVMBootcamp: View {
    
    @StateObject var viewmodel = MVVMBootcampViewModel()
    
    var body: some View {
        ZStack{
            Button(viewmodel.title){
                viewmodel.handleAction()
            }
        }
        .onDisappear{
            viewmodel.cancelTask()
        }
    }
}

struct MVVMBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MVVMBootcamp()
    }
}
