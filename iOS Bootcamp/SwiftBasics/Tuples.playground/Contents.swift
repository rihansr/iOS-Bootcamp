import Foundation

var userName: String = "Rihan"
var isNew: Bool = false
var isPremium: Bool = false

func getName() -> String {
    return userName;
}

func isUserNew() -> (String, Bool) {
    return (userName, isNew)
}

let newUserName = isUserNew().0


func isUserPremium() -> (name: String, premium: Bool) {
    return (userName, isPremium)
}

let premiumUserName = isUserPremium().name

func isNewUserPremium() -> (name: String, new: Bool, premium: Bool) {
    return (userName, isNew, isPremium)
}

func userDetails(info: (name: String, new: Bool, premium: Bool)) {
    
}

let info = isNewUserPremium()

func showUserDetails(info: (name: String, new: Bool, premium: Bool)) {
    print("\(info.name), New: \(info.new), Premium: \(info.premium)")
}

showUserDetails(info: ("Rihan", false, true))
