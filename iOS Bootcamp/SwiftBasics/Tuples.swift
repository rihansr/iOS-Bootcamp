//
//  Tuples.swift
//  FirstIOSProject
//
//  Created by Macuser on 06/10/2023.
//

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
