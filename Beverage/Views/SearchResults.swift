//
//  SearchResults.swift
//  Beverage
//
//  Created by Maxime Duby on 21/07/2022.
//

import SwiftUI
import CoreData

struct SearchResults<T: NSManagedObject, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        ForEach(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey1: String, filterValue1: String, filterKey2: String, filterValue2: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        _fetchRequest = filterValue2.isEmpty ? FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K CONTAINS[cd] %@", filterKey1, filterValue1)) : FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "(%K = %@) AND (%K CONTAINS[cd] %@)", filterKey1, filterValue1, filterKey2, filterValue2))
        self.content = content
    }
}
