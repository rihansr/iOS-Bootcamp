import Foundation

struct Quiz {
    let title: String
    let createdAt: Date?
    let isPremium: Bool?
    
    init(title: String, createdAt: Date?, isPremium: Bool = false) {
        self.title = title
        self.createdAt = createdAt ?? .now
        self.isPremium = isPremium
    }
}


let quiz1 = Quiz(title: "Quiz 1", createdAt: nil)
let quiz2 = Quiz(title: "Quiz 2", createdAt: .now, isPremium: true)


/// "Immutable Struct"
// "All "let" constants = NOT mutable = "cannot mutate it!"
struct UserModel1{
    let name: String
    let isPremium: Bool
}


var user1: UserModel1 = UserModel1(name: "User 1", isPremium: false)
func markUserAsPremium1(){
    print("User#1 Pre: \(user1)")
    user1 = UserModel1(name: user1.name, isPremium: true)
    print("User#1 Post: \(user1)")
}
markUserAsPremium1()

struct UserModel2{
    let name: String
    let isPremium: Bool
    
    func updatePremiumStatus(premium: Bool) -> UserModel2{
        UserModel2(name: name, isPremium: premium)
    }
}

var user2: UserModel2 = UserModel2(name: "User 2", isPremium: false)
func markUserAsPremium2(){
    print("User#2 Pre: \(user2)")
    user2 = user2.updatePremiumStatus(premium: true)
    print("User#2 Post: \(user2)")
}
markUserAsPremium2()

/// "Mutable Struct"
struct UserModel3{
    let name: String
    var isPremium: Bool
}

var user3: UserModel3 = UserModel3(name: "User 3", isPremium: false)
func markUserAsPremium3(){
    print("User#3 Pre: \(user3)")
    user3.isPremium = true
    print("User#3 Post: \(user3)")
}
markUserAsPremium3()

struct UserModel4{
    let name: String
    private(set) var isPremium: Bool
    
    //    mutating func markUserAsPremium(){
    //        isPremium = true
    //    }
    
    mutating func markUserAsPremium(premium: Bool){
        isPremium = premium
    }
}

var user4: UserModel4 = UserModel4(name: "User 4", isPremium: false)
func markUserAsPremium4(){
    print("User#4 Pre: \(user4)")
    user4.markUserAsPremium(premium: true)
    print("User#4 Post: \(user4)")
}
markUserAsPremium4()
