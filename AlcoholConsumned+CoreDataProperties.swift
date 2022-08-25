//
//  AlcoholConsumned+CoreDataProperties.swift
//  Beverage
//
//  Created by Maxime Duby on 19/08/2022.
//
//

import Foundation
import CoreData


extension AlcoholConsumned {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlcoholConsumned> {
        return NSFetchRequest<AlcoholConsumned>(entityName: "AlcoholConsumned")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?

}

extension AlcoholConsumned : Identifiable {

}
