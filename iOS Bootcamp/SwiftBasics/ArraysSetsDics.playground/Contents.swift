import Foundation

// MARK: ARRAY
var fruitsArray: [String] = ["Apple", "Orange", "Guava"]
var fruitsArrays: Array<String> = ["Apple", "Orange", "Guava"]

fruitsArray.append("Grapes")
fruitsArray.append(contentsOf: ["Pineapple", "Banana"])
fruitsArray = fruitsArray + ["Guava", "Mango"]

if let firstItem = fruitsArray.first {
    print(firstItem)
}

if fruitsArray.indices.contains(5){
    print(fruitsArray[4])
}

fruitsArray.insert("Pineapple", at: 1)
fruitsArray.insert(contentsOf: ["Watermelon", "Tangarine"], at: 3)

if fruitsArray.indices.contains(8){
    fruitsArray.remove(at: 8)
}

fruitsArray.removeAll { item in
    item == "Apple"
}

print(fruitsArray)

fruitsArray.removeAll()


// MARK: SET
let fruitsSet: [String] = ["Apple", "Orange", "Guava", "Apple"]

print(fruitsSet)


// MARK: DICTIONARY
var fruitsDic: [Int: String] = [0: "Apple", 1: "Orange", 2: "Guava", 3: "Apple"]

print(fruitsDic[1] ?? "Unknown")

print(fruitsDic)

fruitsDic[3] = "Banana"
fruitsDic[10] = "Pineapple"

fruitsDic.removeValue(forKey: 1)

print(fruitsDic)
