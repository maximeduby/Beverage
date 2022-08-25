//
//  Product+CoreDataProperties.swift
//  Beverage
//
//  Created by Maxime Duby on 26/07/2022.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var abv: Double
    @NSManaged public var category: String
    @NSManaged public var country: String
    @NSManaged public var desc: String
    @NSManaged public var foodPairing: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String
    @NSManaged public var region: String
    @NSManaged public var taste: String?
    @NSManaged public var type: String
    @NSManaged public var variety: String
    @NSManaged public var year: Int16
    @NSManaged public var id: Int16

}

extension Product : Identifiable {

}
