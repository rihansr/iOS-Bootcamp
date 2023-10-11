import Foundation

struct User{
    let name: String
    let isPremium: Bool
    let age: Int
}

let users: [User] = [
    User(name: "Rihan", isPremium: true, age: 29),
    User(name: "David", isPremium: false, age: 32),
    User(name: "Nick", isPremium: true, age: 18),
    User(name: "Jonas", isPremium: false, age: 27),
    User(name: "Rick", isPremium: true, age: 43),
]


// MARK: filter
let premiumUsers1: [User] = users.filter { user in
    user.isPremium
}
/*....or....*/
let premiumUsers2: [User] = users.filter({ $0.isPremium })

print("Premium Users: \(premiumUsers2)")


// MARK: sort
let orderdByAge1: [User] = users.sorted { user1, user2 in
    user1.age > user2.age
}
/*....or....*/
let orderdByAge2: [User] = users.sorted(by: { $0.age > $1.age })

print("Orderd Users: \(orderdByAge2)")


// MARK: map
let userNames1: [String] = users.map { user in
    user.name
}
/*....or....*/
let userNames2: [String] = users.map({ $0.name })

print("Usernames: \(userNames2)")
