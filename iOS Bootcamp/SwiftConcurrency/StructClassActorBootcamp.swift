import SwiftUI

// MARK: VIEW
struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                runTest1()
            }
    }
}

struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp()
    }
}

// MARK: MODELS
/// Value type
///
/// Does not require initialization
/// - struct, enum, String, Int, etc., Tuple, Array(Set, Dict)
/// - Can be mutated
/// - Stored in the Stack
///   - Strored Value types
///   - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
///   - Each thread has it's own stack
/// - Faster
/// - Thread safe!
/// - When you assign or pass value type a new copy of data is created
/// - Example: Data Models, Views
struct MyStruct {
    var title: String
}

struct ImmutableStruct {
    let title: String
    
    func copyWith(title: String) -> ImmutableStruct{
        return ImmutableStruct(title: title)
    }
}

struct MutableStruct{
    private (set) var title: String
    
    mutating func copyWith(title: String) {
        self.title = title
    }
}

/// Reference type
///
/// Have to call init first in "class" whereas there is no need for it in "struct"
/// - class, func, actor
/// - Stored in the Heap
///   - Strored Reference types
///   - Shared across threads
/// - Slower, but synchronized
/// - Not Thread safe!
/// - When you assign or pass reference type a new reference to original instance will be created (pointer)
/// - Inherit from other classess
/// - Example: ViewModels
class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func copyWith(title: String) {
        self.title = title
    }
}

/// Same as Class, but thread safe
/// - Example: Shared 'Manager' and 'Data Store'
actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func copyWith(title: String) {
        self.title = title
    }
}

// MARK: FUNCTIONS
extension StructClassActorBootcamp {
    private func runTest1(){
        copyingStruct()
        copyingClass()
        copyingActor()
    }
    
    private func copyingStruct() {
        let objA = MyStruct(title: "Title #1")
        print("Struct ObjectA-Pre:", objA.title)
        
        var objB = objA
                
        // if 'objB' is a 'let' constant then we cannot assign a property
        objB.title = "Title #2"
        print("Struct ObjectA:", objA.title)
        print("Struct ObjectB:", objB.title)
    }
    
    private func copyingClass(){
        let objA = MyClass(title: "Title #1")
        print("Class ObjectA-Pre:", objA.title)
        
        let objB = objA
        
        // Modifying data affects the original
        objB.title = "Title #2"
        print("Class ObjectA:", objA.title)
        print("Class ObjectB:", objB.title)
    }
    
    private func copyingActor(){
        Task{
            let objA = MyActor(title: "Title #1")
            print("Actor ObjectA-Pre:", await objA.title)
            
            let objB = objA
            
            // Modifying data affects the original
            await objB.copyWith(title: "Title #2")
            await print("Actor ObjectA:", objA.title)
            await print("Actor ObjectB:", objB.title)
        }
    }
}

extension StructClassActorBootcamp {
    private func runTest2(){
        structInstanceTest()
        classInstanceTest()
    }
    
    private func structInstanceTest() {
        // Changing the entire object
        var struct1 = MyStruct(title: "Title #1")
        print("Struct 1:", struct1.title)
        struct1.title = "Title #2"
        print("Struct 1:", struct1.title)
        
        var struct2 = MutableStruct(title: "Title #1")
        print("Struct 2:", struct2.title)
        struct2.copyWith(title: "Title #2")
        print("Struct 2:", struct2.title)
        
        var struct3 = ImmutableStruct(title: "Title #1")
        print("Struct 3:", struct3.title)
        struct3 = ImmutableStruct(title: "Title #2")
        print("Struct 3:", struct3.title)
        
        var struct4 = ImmutableStruct(title: "Title #1")
        print("Struct 4:", struct4.title)
        struct4 = struct4.copyWith(title: "Title #2")
        print("Struct 4:", struct4.title)
    }
    
    private func classInstanceTest() {
        // Changing the value of the object
        let class1 = MyClass(title: "Title #1")
        print("Class 1:", class1.title)
        class1.title = "Title #2"
        print("Class 1:", class1.title)
        
        let class2 = MyClass(title: "Title #1")
        print("Class 2:", class2.title)
        class2.copyWith(title: "Title #2")
        print("Class 2:", class2.title)
    }
    
}
