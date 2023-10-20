import SwiftUI

// MARK: DATA MANAGER
actor SendableDataManager{
    
    func saveUserInfo(userInfo: MutableUserClassInfo){}
}

// MARK: MODELS
/// It's by default a sendable struct but there are some slight performance benefits
struct UserActorInfo: Sendable {
    let name: String
}

final class ImmutableUserClassInfo: Sendable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

/// Convert to Thread-Safe
/// - Warning: Not-Recommended approach
final class MutableUserClassInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.MyApp.MutableUserClassInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func copyWith(name: String){
        queue.sync {
            self.name = name
        }
    }
}

// MARK: VIEWMODEL
final class SendableBootcampViewModel: ObservableObject {
    private let manager = SendableDataManager()
    
    func updateUserInfo() async{
        let userInfo = MutableUserClassInfo(name: "Rihan")
        await manager.saveUserInfo(userInfo: userInfo)
    }
}

// MARK: UI
struct SendableBootcamp: View {
    
    @StateObject var viewmodel = SendableBootcampViewModel()
    
    var body: some View {
        Text("Hello World")
            .task {
                await viewmodel.updateUserInfo()
            }
    }
}

// MARK: PREVIEW
struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
