//
//  CoreDataManager.swift
//  Beverage
//
//  Created by Maxime Duby on 23/07/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BeverageModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    func save(item: DataStructure) {
        let product = Product(context: persistentContainer.viewContext)
        product.name = item.name
        product.id = item.id
        product.category = item.category
        product.type = item.type
        product.country = item.country
        product.region = item.region
        product.desc = item.desc
        product.year = item.year
        product.abv = item.abv
        product.taste = item.taste
        product.foodPairing = item.foodPairing
        product.variety = item.variety
        product.isFavorite = false
        
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save product \(error)")
        }
    }
    
}
