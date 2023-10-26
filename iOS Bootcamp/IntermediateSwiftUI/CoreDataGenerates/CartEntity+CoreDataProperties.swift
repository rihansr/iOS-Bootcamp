//
//  CartEntity+CoreDataProperties.swift
//  iOS Bootcamp
//
//  Created by Macuser on 26/10/2023.
//
//

import Foundation
import CoreData


extension CartEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartEntity> {
        return NSFetchRequest<CartEntity>(entityName: "CartEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var items: NSSet?
    
    public var foodItems: [FoodEntity] {
        let items = self.items as? Set<FoodEntity> ?? []
        return Array(items)
    }
}

// MARK: Generated accessors for items
extension CartEntity {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: FoodEntity)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: FoodEntity)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension CartEntity : Identifiable {

}
