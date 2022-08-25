//
//  BeverageApp.swift
//  Beverage
//
//  Created by Maxime Duby on 17/07/2022.
//

import SwiftUI

@main
struct BeverageApp: App {
    
    @StateObject var vm = HomeViewModel()
    let cdm = CoreDataManager.shared
    @AppStorage("didLaunchBefore") var didLaunchBefore: Bool = false
    
    init() {
        if !didLaunchBefore {
            let data: [DataStructure] = DataStructure.allData
            for item in data {
                cdm.save(item: item)
            }
            didLaunchBefore = true
        }
    }
  
    var body: some Scene {        
        WindowGroup {
            Home()
                .environmentObject(vm)
                .environment(\.managedObjectContext, cdm.persistentContainer.viewContext)
        }
    }
}
