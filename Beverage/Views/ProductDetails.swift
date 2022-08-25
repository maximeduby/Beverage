//
//  ProductCard.swift
//  Beverage
//
//  Created by Maxime Duby on 23/07/2022.
//

import SwiftUI
import SlideOverCard
import HealthKit

struct ProductDetails: View {
    
    var product: Product
    @Environment(\.presentationMode) var presentationMode
    let moc = CoreDataManager.shared.persistentContainer.viewContext
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showDrinkConsuInfo: Bool = false
    @State private var showDesc = false
    @State private var isFavorite = false
    @GestureState private var addTapped = false
    @State private var addPressed = false
    @State private var drinkTime = Date()
    @State private var selectedUnit = "standard"
    private let units = ["standard", "mL", "fl oz"]
    
    @State private var selectedVolume: Float = 1.0
    private var volumes: [Float] {
        switch selectedUnit {
        case "standard":
            return (1...10).map { Float($0) }
        case "mL":
            return (1...80).map { Float($0 * 5)}
        case "fl oz":
            return (1...40).map{Float($0) / 2}
        default:
            return []
        }
    }
    
    private func amountOfAlcohol(in amount: Double, of unit: String) -> Double {
        switch unit {
        case "standard":
            return amount * 14
        case "mL":
            return amount * (product.abv/100.0) * 0.789
        case "fl oz":
            return amount * product.abv * 0.82353
        default:
            return 0.0
        }
        
    }
    var hsManager = HealthStoreManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                Wave(amplitude: 0.3)
                    .fill(Color("bgd"))
                    .frame(height: 400)
                Wave(amplitude: 0.8)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .top, endPoint: .bottom))
                    .frame(height: 200)
                Wave(amplitude: 0.5)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .top, endPoint: .bottom))
                    .frame(height: 130)
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
            }
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10){
                Image(String(product.id))
                    .resizable()
                    .aspectRatio(contentMode: product.category == "beer" ? .fill : .fit)
                    .frame(width: 200, height: 300)
                    .padding(.top, 100)
                Text(product.name)
                    .font(.custom("Didot", size: 25))
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                TabView {
                    GeometryReader { proxy in
                        let minX = proxy.frame(in: .global).minX
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.ultraThinMaterial)
                            ZStack{
                                VStack{
                                    HStack{
                                        VStack{
                                            Text("TYPE")
                                                .tracking(3)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.secondary)
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(product.category))
                                                    .frame(maxHeight: 60)
                                                Text(product.type.uppercased())
                                                    .font(.subheadline)
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        VStack{
                                            Text("YEAR")
                                                .tracking(3)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.secondary)
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(product.category))
                                                    .frame(maxHeight: 60)
                                                Text(product.year != 0 ? String(product.year) : "----")
                                                    .font(.subheadline)
                                            }
                                        }
                                        VStack{
                                            Text("ABV")
                                                .tracking(3)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.secondary)
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(product.category))
                                                    .frame(maxHeight: 60)
                                                Text("\(String(product.abv))%")
                                                    .font(.subheadline)
                                            }
                                        }
                                    }
                                    .padding(.bottom)
                                    VStack(spacing: 5){
                                        Text("DESCRIPTION")
                                            .tracking(3)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.secondary)
                                        
                                        Text(product.desc)
                                            .font(.caption)
                                            .onTapGesture {
                                                showDesc.toggle()
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .padding(.bottom)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .blur(radius: abs(minX/50))
                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
                    }
                    GeometryReader { proxy in
                        let minX = proxy.frame(in: .global).minX
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.ultraThinMaterial)
                            ZStack(alignment: .top){
                                VStack{
                                    VStack{
                                        Text("COUNTRY")
                                            .tracking(3)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.secondary)
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(product.category))
                                                .frame(maxHeight: 60)
                                            Text(product.country)
                                        }
                                    }
                                    VStack{
                                        Text("REGION")
                                            .tracking(3)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.secondary)
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(product.category))
                                                .frame(maxHeight: 60)
                                            Text(!product.region.isEmpty ? String(product.region) : "Not Specified")
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .padding(.bottom)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .blur(radius: abs(minX/50))
                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
                    }
                    GeometryReader { proxy in
                        let minX = proxy.frame(in: .global).minX
                        
                        
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.ultraThinMaterial)
                            ZStack(alignment: .top){
                                VStack{
                                    HStack{
                                        VStack{
                                            Text("TASTE")
                                                .tracking(3)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.secondary)
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(product.category))
                                                    .frame(maxHeight: 160)
                                                VStack {
                                                    ForEach(product.taste!.components(separatedBy: ", "), id: \.self) { el in
                                                        Text(el)
                                                            .font(.caption)
                                                    }
                                                }
                                                .padding(.vertical)
                                            }
                                        }
                                        if product.foodPairing != "" {
                                            VStack{
                                                Text("FOOD PAIRING")
                                                    .tracking(3)
                                                    .font(.caption)
                                                    .bold()
                                                    .foregroundColor(.secondary)
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(Color(product.category))
                                                        .frame(maxHeight: 160)
                                                    VStack {
                                                        ForEach(product.foodPairing.components(separatedBy: ", "), id: \.self) { el in
                                                            Text(el)
                                                                .font(.caption)
                                                        }
                                                    }
                                                    .padding(.vertical)
                                                }
                                            }
                                        }
                                    }
                                    if product.category == "wine"{
                                        VStack{
                                            Text("VARIETY")
                                                .tracking(3)
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.secondary)
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(Color(product.category))
                                                    .frame(maxHeight: 40)
                                                Text(product.variety)
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .padding(.bottom)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .blur(radius: abs(minX/50))
                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
                    }
                }
                .tabViewStyle(.page)
                
                
                
                
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
            
            ZStack {
                VStack {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .light))
                }
                .frame(width: 60, height: 60)
                .background(
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        Circle()
                            .stroke(Color.clear, lineWidth: 8)
                            .shadow(color: Color(product.category), radius: 3, x: -5, y: -5)
                        
                    }
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .trim(from: addTapped ? 0.001 : 1, to: 1)
                        .stroke(.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .animation(.easeInOut)
                )
                .shadow(color: Color(product.category), radius: 10, x: -10, y: -10)
                .shadow(color: Color("\(product.category)_dark"), radius: 10, x: 10, y: 10)
                .scaleEffect(addTapped ? 1.2 : 1)
                .gesture(
                    LongPressGesture().updating($addTapped) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
                        .onEnded { valie in
                            self.addPressed.toggle()
                        }
                    
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .offset(x: -100, y: -60)
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
            ZStack {
                ZStack {
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .light))
                        .offset(x: isFavorite ? -90 : 0, y: isFavorite ? -90 : 0)
                        .rotation3DEffect(Angle(degrees: isFavorite ? 20 : 0), axis: (x: 10, y: -10, z: 0))
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .light))
                        .offset(x: isFavorite ? 0 : 90, y: isFavorite ? 0 : 90)
                        .rotation3DEffect(Angle(degrees: isFavorite ? 0 : 20), axis: (x: -10, y: 10, z: 0))
                }
                .frame(width: 60, height: 60)
                .background(
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(product.category), Color("\(product.category)_dark")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        
                    }
                )
                .clipShape(Circle())
                .shadow(color: Color(product.category), radius: 10, x: -10, y: -10)
                .shadow(color: Color("\(product.category)_dark"), radius: 10, x: 10, y: 10)
                .onTapGesture {
                    isFavorite.toggle()
                    product.isFavorite.toggle()
                    try? moc.save()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .offset(x: -20, y: -60)
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
            
        }
        .slideOverCard(isPresented: $showDesc) {
            Text(product.desc)
                .font(.body)
        }
        .onAppear {
            isFavorite = product.isFavorite
        }
        .slideOverCard(isPresented: $addPressed) {
            VStack {
                Text("How much have you had to drink?")
                    .font(.title3)
                    .bold()
                DatePicker("Consumed at", selection: $drinkTime, displayedComponents: .hourAndMinute)
                GeometryReader { geometry in
                    HStack(spacing:0) {
                        Picker("Volume", selection: $selectedVolume) {
                            ForEach(volumes, id: \.self) {
                                
                                Text($0.truncatingRemainder(dividingBy: 1) == 0 ? String(Int($0)) : String($0))
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        
                        
                        Picker("Volume Unit", selection: $selectedUnit) {
                            ForEach(units, id : \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                        
                        
                    }
                }
                .frame(maxHeight: 200)
                
                ZStack {
                    Button {
                        let alcoholConsumned = AlcoholConsumned(context: moc)
                        alcoholConsumned.amount = amountOfAlcohol(in: Double(selectedVolume), of: selectedUnit)
                        alcoholConsumned.date = drinkTime
                        try? moc.save()
                        
                        let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.numberOfAlcoholicBeverages)
                        let alcConsuValue = HKQuantitySample.init(type: quantityType!, quantity: HKQuantity.init(unit: HKUnit.count(), doubleValue: alcoholConsumned.amount / 14), start: drinkTime, end: drinkTime)
                        
                        if hsManager.checkStatus(quantityType: quantityType!)  && vm.enableHK{
                            self.hsManager.healthStore?.save(alcConsuValue, withCompletion: { success, error in
                                if error != nil {
                                    print(error!)
                                }
                                if success {
                                    print("success")
                                }
                            })
                            
                        }
                        
                        addPressed = false
                    } label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(product.category))
                                .frame(width: 200, height: 50)
                                .shadow(color: Color(product.category), radius: 3, x: 0, y: 0)
                            //Text("Add Consumption")
                            Text("Add to consumption")
                            
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .padding()
                            .onTapGesture {
                                showDrinkConsuInfo.toggle()
                            }
                    }
                }
                
            }
            .onAppear{
                
                hsManager.requestAuthorization { success in
                    print("ok")
                }
                
            }

            
        }
                .slideOverCard(isPresented: $showDrinkConsuInfo) {
            Text("A standard drink contains 14g of pure alcohol and represents:")
            VStack(alignment: .center){
                
                Text("5 fl oz (150mL) of wine with about 12% alcohol")
                Text("or")
                Text("1.5 fl oz (45mL) of spirit with about 40% alcohol")
                Text("or")
                Text("12 fl oz (350mL) of beer with about 5% alcohol")
                
            }
        }
        
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataManager.shared.persistentContainer.viewContext
        let products = try? moc.fetch(Product.fetchRequest())
        Group {
            ProductDetails(product: products![1])
            ProductDetails(product: products![0]).preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, moc)
        .environmentObject(HomeViewModel())
        
    }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
        
    }
}
