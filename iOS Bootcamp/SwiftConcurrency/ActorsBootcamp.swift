import SwiftUI

@globalActor final class MyGlobalActor {
    static var shared = MyActorManager()
}

// @MainActor / @MyGlobalActor
class MyDataManager{
    static let instance = MyDataManager()
    
    // @MainActor var data: [String] = []
    var data: [String] = []
    private let lock = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    // @MainActor /
    @MyGlobalActor func getGlobalRandomData() -> String? {
        // Using @MainActor
        /*
         Task{
         await MainActor.run(body: {
         self.data.append(UUID().uuidString)
         })
         }
         */
        
        // Using @MyGlobalActor
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    func getRandomQueueData(completionHandler: @escaping (_ title: String?) -> ()) {
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

actor MyActorManager {
    static let instance = MyActorManager()
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    nonisolated func getUUID() -> String {
        return UUID().uuidString
    }
}

struct UsingClassView: View {
    let manager = MyDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View{
        ZStack{
            Color.yellow.opacity(0.25).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            // Using @MyGlobalActor
            Task{
                if let data = await manager.getGlobalRandomData(){
                    self.text = data
                }
            }
            
            // Without using global actor
            /*
             DispatchQueue.global(qos: .background).async {
             // Without using actor
             if let data = manager.getRandomData(){
             DispatchQueue.main.async {
             self.text = data
             }
             }
             
             // Using DispatchQueue(lebel:)
             manager.getRandomQueueData { title in
             if let data = title {
             DispatchQueue.main.async {
             self.text = data
             }
             }
             }
             }
             */
        }
    }
}

struct UsingActorView: View {
    let manager = MyActorManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color.cyan.opacity(0.25).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onAppear{
            text = manager.getUUID()
        }
        .onReceive(timer) { _ in
            Task{
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
        }
    }
}

struct UsingGlobalActorView: View {
    let manager = MyGlobalActor.shared
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color.red.opacity(0.25).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task{
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
        }
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView{
            UsingClassView()
                .tabItem {
                    Label("Queue", systemImage: "house.fill")
                }
            UsingActorView()
                .tabItem {
                    Label("Actor", systemImage: "magnifyingglass")
                }
            UsingGlobalActorView()
                .tabItem {
                    Label("Global", systemImage: "globe")
                }
        }
    }
}

struct ActorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActorsBootcamp()
    }
}
