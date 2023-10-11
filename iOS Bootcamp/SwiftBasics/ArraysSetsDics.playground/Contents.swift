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
var fruitsSetA: Set<String> = ["Apple", "Orange", "Guava", "Apple", "Peach"] /* or Set<Int>()*/
var fruitsSetB: Set<String> = ["Pineapple", "Grapes", "Orange", "Pomegranate"]

fruitsSetA.insert("Pineapple")
fruitsSetB.remove("Peach")

print("Both sets have the same fruits? \(fruitsSetA == fruitsSetB)")
print("Fruits setA has all the fruits of setB? \(fruitsSetB.isSubset(of: fruitsSetA))")

var allFruits = fruitsSetA.union(fruitsSetB)
print("All fruits set: \(allFruits)")

var commonFruits = fruitsSetA.intersection(fruitsSetB)
print("Common fruits set: \(commonFruits)")

var otherFruits = fruitsSetA.symmetricDifference(fruitsSetB)
print("All Fruits(excluding common) set: \(otherFruits)")

var otherFruitsInSet1 = fruitsSetA.subtracting(fruitsSetB)
print("After excluding common fruits from setA: \(otherFruitsInSet1)")

var otherFruitsInSet2 = fruitsSetB.subtracting(fruitsSetA)
print("After excluding common fruits from setB: \(otherFruitsInSet2)")


// MARK: DICTIONARY
var fruitsDic: [Int: String] = [0: "Apple", 1: "Orange", 2: "Guava", 3: "Apple"]

print(fruitsDic[1] ?? "Unknown")

print(fruitsDic)

print("Keys: \(fruitsDic.keys)\nValues: \(fruitsDic.values)")

fruitsDic[3] = "Banana"
fruitsDic[10] = "Pineapple"

fruitsDic.removeValue(forKey: 1)
fruitsDic.removeAll()

print(fruitsDic)
