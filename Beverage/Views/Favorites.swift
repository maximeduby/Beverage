//
//  Favorites.swift
//  Beverage
//
//  Created by Maxime Duby on 16/08/2022.
//

import SwiftUI

struct Favorites: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color("bgd")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                HStack {
                    Text("Favorites")
                        .font(.title)
                        .bold()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                        
                        Text("🍷 WINES")
                            .font(.title2)
                            .tracking(3)
                            .padding()
                        ScrollView(.horizontal) {
                            HStack{
                                SearchResults(filterKey1: "isFavorite", filterValue1: "1", filterKey2: "category", filterValue2: "wine") { (product: Product) in
                                    ProductCard(product: product)
                                        
                                }
                            }
                            .padding(.horizontal)
                        }
                        .ignoresSafeArea()
                        Divider()
                        Text("🍺 BEERS")
                            .font(.title2)
                            .tracking(3)
                            .padding()
                        ScrollView(.horizontal) {
                            HStack{
                                SearchResults(filterKey1: "isFavorite", filterValue1: "1", filterKey2: "category", filterValue2: "beer") { (product: Product) in
                                    ProductCard(product: product)     
                                }
                            }
                            .padding(.horizontal)
                        }
                        .ignoresSafeArea()
                        Divider()
                        Text("🍸 SPIRITS")
                            .font(.title2)
                            .tracking(3)
                            .padding()
                        ScrollView(.horizontal) {
                            HStack{
                                SearchResults(filterKey1: "isFavorite", filterValue1: "1", filterKey2: "category", filterValue2: "spirit") { (product: Product) in
                                    ProductCard(product: product)
                                        
                                }
                            }
                            .padding(.horizontal)
                        }
                        .ignoresSafeArea()
                        
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Favorites()
            Favorites().preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
    }
}
