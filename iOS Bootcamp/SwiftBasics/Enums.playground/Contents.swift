import Foundation

enum Brand{
    case honda, ford, toyota
    
    var title: String {
        switch self {
        case .honda:
            return "Honda"
        case .ford:
            return "Ford"
        case .toyota:
            return "Toyota"
        }
    }
}

struct Car{
    let brand: Brand
    let model: String
}


var car1 = Car(brand: .ford, model: "Fiesta")
var car2 = Car(brand: .toyota, model: "Camry")
var car3 = Car(brand: .ford, model: "Focus")
var car4 = Car(brand: .honda, model: "Civic")

print(car1.brand)
print(car1.brand.title)


