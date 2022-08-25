//
//  HealthStoreManager.swift
//  Beverage
//
//  Created by Maxime Duby on 18/08/2022.
//

import Foundation
import HealthKit

class HealthStoreManager {
    
    var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let bacType = HKQuantityType.quantityType(forIdentifier: .bloodAlcoholContent)!
        let alcConsuType = HKQuantityType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [bacType, alcConsuType], read: []) {(success, error) in
            completion(success)
        }
    }
    
    func checkStatus(quantityType: HKQuantityType) -> Bool {
        return healthStore!.authorizationStatus(for: quantityType) == .sharingAuthorized
    }
}
