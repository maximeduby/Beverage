//
//  Home.swift
//  Beverage
//
//  Created by Maxime Duby on 21/07/2022.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject private var vm: HomeViewModel
    @State private var index: Int = 0
    @State private var categoryFilter = "wine"
    @State private var showFavorites = false
    @State private var showDashboard = false
    
    private var drinkList = ["wine", "beer", "spirit"]
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
        ZStack(alignment: .top){
            Color("bgd")
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 150)
                .foregroundColor(Color(drinkList[index]))
                .animation(.easeInOut, value: index)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Button(action: {
                        showDashboard.toggle()
                    }, label: {
                        Image(systemName: "rectangle.3.offgrid.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                    })
                    .sheet(isPresented: $showDashboard) {
                        Dashboard()
                    }
                    Spacer()
                    Text(drinkList[index].uppercased())
                    //.font(.title)
                        .font(.custom("Didot", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .animation(.interactiveSpring())
                    Spacer()
                    Button(action: {
                        showFavorites.toggle()
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                    })
                    .sheet(isPresented: $showFavorites) {
                        Favorites()
                    }
                }
                .padding(25)
                
                SearchBar(searchText: $vm.searchText)
                    .padding()
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 115, height: 45)
                            .foregroundColor(index == 0 ? Color("wine") : Color("bgd"))
                            .animation(.easeInOut, value: index)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.primary, lineWidth: 2)
                            )
                        HStack{
                            Text("🍷")
                            Text("WINES")
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                        }
                        
                    }
                    .onTapGesture {
                        index = 0
                        categoryFilter = "wine"
                    }
                    Spacer(minLength: 0)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 115, height: 45)
                            .foregroundColor(index == 1 ? Color("beer") : Color("bgd"))
                            .animation(.easeInOut, value: index)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.primary, lineWidth: 2)
                            )
                        
                        HStack{
                            Text("🍺")
                            Text("BEERS")
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                        }
                        
                    }
                    .onTapGesture {
                        index = 1
                        categoryFilter = "beer"
                    }
                    Spacer(minLength: 0)
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 115, height: 45)
                            .foregroundColor(index == 2 ? Color("spirit") : Color("bgd"))
                            .animation(.easeInOut, value: index)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.primary, lineWidth: 2)
                            )
                        HStack{
                            Text("🍸")
                            Text("SPIRITS")
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                        }
                        
                    }
                    .onTapGesture {
                        index = 2
                        categoryFilter = "spirit"
                    }
                }
                .padding(.horizontal, 10)
                
//                HStack{
//                    Image(systemName: "line.3.horizontal.decrease.circle")
//                        .font(.footnote)
//                    Text("Filter by type")
//                        .font(.footnote)
//                }
//                .frame(maxWidth: .infinity, alignment: .center)
//                .padding(5)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        SearchResults(filterKey1: "category", filterValue1: categoryFilter, filterKey2: "name", filterValue2: vm.searchText) { (product: Product) in
                            ProductCard(product: product)
                        }
                    }
                    .padding()
                }
                .ignoresSafeArea()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
            Home().preferredColorScheme(.dark)
        }
        .environmentObject(HomeViewModel())
        .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
    }
}
