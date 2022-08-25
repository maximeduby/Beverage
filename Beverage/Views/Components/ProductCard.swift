//
//  ProductCard.swift
//  Beverage
//
//  Created by Maxime Duby on 27/07/2022.
//

import SwiftUI

struct ProductCard: View {
    var product: Product
    
    @State private var showDetails = false
    
    var origins: String {
        return product.region.isEmpty ? product.country : "\(product.country), \(product.region)"
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 170, height: 250)
                Image(String(product.id))
                    .resizable()
                    .cornerRadius(16)
                    .aspectRatio(contentMode: product.category == "beer" ? .fill : .fit)
                    .frame(height: 170)
                    .padding()
            }
            VStack(alignment: .leading){
                Text(product.type.uppercased())
                    .tracking(3)
                    .font(.caption)
                    .opacity(0.5)
                Text(product.name)
                    .bold()
                    .font(.system(size: 14))
                    .lineLimit(2)
                Text(origins)
                    .font(.caption)
                    .lineLimit(1)
            }
            .padding(12)
            .frame(width: 170, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
        .onTapGesture {
            showDetails.toggle()
        }
        .sheet(isPresented: $showDetails) {
            ProductDetails(product: product)
        }
    }
        
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataManager.shared.persistentContainer.viewContext
        let product = try? moc.fetch(Product.fetchRequest())
        
        Group{
            ProductCard(product: product![20])
            ProductCard(product: product![0]).preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, moc)
    }
}
