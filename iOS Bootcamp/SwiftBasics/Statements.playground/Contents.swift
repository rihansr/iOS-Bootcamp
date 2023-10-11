import Foundation

// MARK: switch Statement
/// Switch Statement with fallthrough
let weekday = "Sun"
switch weekday {
case "Sat":
    print("Saturday")
case "Sun":
    fallthrough
case "Sunday":
    print("Sunday")
default:
    print("Weekday")
}

/// Switch Statement with Range
let bmi = 38.4
switch bmi {
case 0..<18:
    print("Underweight")
case 18..<25:
    print("Normal")
case 25..<30:
    print("Overweight")
case 30..<35:
    print("Obese")
default:
    print("Extremely Obese")
}

/// Tuple in Switch Statement
let user = ("Rihan", 29)
switch user {
case ("Rick", 35):
    print("Rick is 35 years old")
case ("Rihan", 29):
    print("Rihan is 29 years old")
case ("Jonas", 12):
    print("Jonas is 12 years old")
default:
    print("Not known")
}


// MARK: guard Statement
/// guard Statement Inside a Function
func checkOddEven(number: Int){
    guard number % 2 == 0 else {
        print("Odd Number")
        return
    }
    print("Even Number")
}
checkOddEven(number: 34)

/// guard with multiple conditions
func checkJobEligibility(age: Int){
    // if (age < 18 && age >= 40)..else..
    guard age >= 18, age <= 40 else {
        print("Not Eligible for Job")
        return
    }
    print("You are eligible for this job")
}
checkJobEligibility(age: 34)

/// guard-let Statement
func checkAge(age: Int?){
    guard let myAge = age else {
        print("Age is undefined")
        return
    }
    print("My age is \(myAge)")
}
checkAge(age: nil)
