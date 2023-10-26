//
//  FoodEntity+CoreDataProperties.swift
//  iOS Bootcamp
//
//  Created by Macuser on 26/10/2023.
//
//

import Foundation
import CoreData


extension FoodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntity> {
        return NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var cartItem: CartEntity?
    
    public var unrappedName: String {
        name ?? "Unknown"
    }
}

extension FoodEntity : Identifiable {
    
}
