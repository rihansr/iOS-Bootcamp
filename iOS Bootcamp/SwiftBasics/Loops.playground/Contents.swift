import Foundation

// MARK: for Loop
/// for Loop With Range
for i in 0..<10 /* 0...9 */ {
    print(i)
}

/// for Loop with Stride Function
for i in stride(from: 0, to: 10, by: 2){
    print(i)
}

/// Loop Over Array
let fruits = ["Apple", "Orange", "Mango", "Pineapple", "Guava"]

for i in fruits.indices {
    print(i)
}

for fruit in fruits {
    print(fruit)
}

for (i, fruit) in fruits.enumerated(){
    print("\(i) : \(fruit)")
}

/// for Loop with where Clause
for fruit in fruits where fruit != "Orange" {
    print(fruit)
}


// MARK: while Loop
var i = 0, n = 5
while (i<=n){
    print(i)
    i+=1
}

// MARK: repeat...while Loop
var j = 0, m = 5
repeat{
    print(j)
    j+=1
} while(j<=m)
