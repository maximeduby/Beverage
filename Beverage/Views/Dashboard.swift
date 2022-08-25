//
//  PersonalInfo.swift
//  Beverage
//
//  Created by Maxime Duby on 17/08/2022.
//

import SwiftUI
import HealthKit
import UIKit
import CoreData
import SlideOverCard

struct Dashboard: View {
    
    @Environment(\.presentationMode) var presentationMode
    let moc = CoreDataManager.shared.persistentContainer.viewContext
    @EnvironmentObject private var vm: HomeViewModel
    
    @AppStorage("sex") var sex: String = "male"
    @AppStorage("weight") var weight: Double = 70.0
    @AppStorage("dbFirstTime") var dbFirstTime: Bool = true
    
    @State private var showPersonalData: Bool = false
    @State private var showBACInfo: Bool = false
    @State private var showAlcConsumInfo: Bool = false
    @State private var showDrivingCondiInfo: Bool = false
    
    
    @State private var firstDrinkTime = Date()
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var alcoholConsumned: FetchedResults<AlcoholConsumned>
    
    @State private var bac: Double = 0.0
    @State private var timeBeforeZero: Double = 0.0
    @State private var drinksIntake: Double = 0.0
    @State private var drivingConditionIndex = 0
    
    private let drivingConditions = ["SAFE", "IMPAIRED", "LEGALLY INTOXICATED"]
    private let drivingColor = ["spirit", "beer", "wine"]
    
    private func resetConsumption() {
        for data in alcoholConsumned {
            moc.delete(data)
        }
        try? moc.save()
    }
    
    private var hsManager: HealthStoreManager?
    
    init() {
        hsManager = HealthStoreManager()
    }
    
    private func sendDataToHK(bac: Double) {
        let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodAlcoholContent)
        let bacValue = HKQuantitySample.init(type: quantityType!, quantity: HKQuantity.init(unit: HKUnit.percent(), doubleValue: (bac/100)), start: Date.now, end: Date.now)
        
        if (hsManager?.checkStatus(quantityType: quantityType!))! {
            self.hsManager?.healthStore?.save(bacValue, withCompletion: { success, error in
                if error != nil {
                    print(error!)
                    
                }
                if success {
                    print("success")
                }
            })
            
        }
        
        
    }
    var body: some View {
        ZStack(alignment: .top){
            Color("bgd")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Dashboard")
                    .font(.title)
                    .bold()
                    .padding()
                VStack{
                    HStack{
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                            .foregroundColor(vm.enableHK ? Color("spirit") : Color("wine"))
                        Text("Send Data to the Health App: " + (vm.enableHK ? "On" : "Off"))
                            .font(.caption)
                    }
                    ZStack(alignment: .top) {
                        ZStack(alignment: .bottom) {
                            LinearGradient(gradient: Gradient(colors: [Color("wine"), Color("wine_dark")]), startPoint: .top, endPoint: .bottom)
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(height: 40)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
                            HStack {
                                Text("Blood Alcohol Content")
                                    .bold()
                                Image(systemName: "questionmark.circle")
                                    .onTapGesture {
                                        showBACInfo.toggle()
                                    }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .padding(.horizontal)
                            
                        }
                        HStack{
                            VStack {
                                Text("BAC")
                                    .foregroundColor(Color("lightGray"))
                                    .tracking(3)
                                    .font(.caption)
                                Text(String(format: "%.3f", bac) + "%")
                                    .font(.custom("Avenir", size: 35))
                                    .foregroundColor(.white)
                                    .bold()
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            Divider()
                                .frame(width: 1, height: 80)
                                .overlay(.white)
                            VStack {
                                Text("TIME BEFORE 0%")
                                    .foregroundColor(Color("lightGray"))
                                    .tracking(3)
                                    .font(.caption)
                                Text(String(format: "%.1f", timeBeforeZero) + " hrs")
                                    .font(.custom("Avenir", size: 35))
                                    .foregroundColor(.white)
                                    .bold()
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                        
                    }
                    .cornerRadius(20)
                    .frame(height: 140)
                    .padding(.horizontal)
                    Divider()
                    ZStack(alignment: .top) {
                        ZStack(alignment: .bottom) {
                            LinearGradient(gradient: Gradient(colors: [Color("wine"), Color("wine_dark")]), startPoint: .top, endPoint: .bottom)
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(height: 40)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
                            HStack {
                                Text("Alcohol Consumption")
                                    .bold()
                                Image(systemName: "questionmark.circle")
                                    .onTapGesture {
                                        showAlcConsumInfo.toggle()
                                    }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            .padding(.horizontal)
                            
                        }
                        ZStack{
                            VStack {
                                Text("AMOUNT")
                                    .foregroundColor(Color("lightGray"))
                                    .tracking(3)
                                    .font(.caption)
                                Text(String(format: drinksIntake.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f", drinksIntake) + " drinks")
                                    .font(.custom("Avenir", size: 35))
                                    .foregroundColor(.white)
                                    .bold()
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                        
                    }
                    .cornerRadius(20)
                    .frame(height: 140)
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack(alignment: .top) {
                            ZStack(alignment: .bottom) {
                                LinearGradient(gradient: Gradient(colors: [Color("wine"), Color("wine_dark")]), startPoint: .top, endPoint: .bottom)
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 40)
                                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
                                HStack {
                                    Text("Driving Condition")
                                        .bold()
                                    Image(systemName: "questionmark.circle")
                                        .onTapGesture {
                                            showDrivingCondiInfo.toggle()
                                        }
                                }
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                                .padding(.horizontal)
                            }
                            ZStack{
                                VStack {
                                    Text(drivingConditions[drivingConditionIndex])
                                        .foregroundColor(Color("lightGray"))
                                        .tracking(3)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                    
                                    ZStack{
                                        Circle()
                                            .fill(.white)
                                            .frame(height: 50)
                                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 0)
                                        
                                        Image(systemName: "car.circle.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(Color(drivingColor[drivingConditionIndex]))
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                        }
                        .cornerRadius(20)
                        .frame(height: 140)
                        
                        ZStack(alignment: .top) {
                            ZStack(alignment: .bottom) {
                                LinearGradient(gradient: Gradient(colors: [Color("wine"), Color("wine_dark")]), startPoint: .top, endPoint: .bottom)
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 40)
                                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
                                HStack {
                                    Text("First Drink")
                                        .bold()
                                }
                                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                                .padding(.horizontal)
                            }
                            ZStack{
                                
                                VStack {
                                    Text("TIME")
                                        .foregroundColor(Color("lightGray"))
                                        .tracking(3)
                                        .font(.caption)
                                    if alcoholConsumned.isEmpty {
                                        Text("--:--")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding(.vertical, 10)
                                    } else {
                                        Text(firstDrinkTime, format: .dateTime.hour().minute())
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding(.vertical, 10)
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                            
                        }
                        .cornerRadius(20)
                        .frame(width: 130, height: 140)
                    }
                    .padding(.horizontal)
                    Divider()
                    Text("Reset Consumption")
                        .foregroundColor(Color(.systemBlue))
                        .padding()
                        .onTapGesture {
                            resetConsumption()
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .onAppear {
                    var rawBAC = 0.0
                    var deltaFirstDrink = 0.0
                    let eliminationRate = sex == "male" ? 0.015 : 0.017
                    
                    for data in alcoholConsumned {
                        let deltaTime = (Date().timeIntervalSinceReferenceDate - data.date!.timeIntervalSinceReferenceDate) / (60.0 * 60.0)
                        if deltaTime > deltaFirstDrink {
                            deltaFirstDrink = deltaTime
                            self.firstDrinkTime = data.date ?? Date.now
                        }
                        rawBAC += (data.amount * 100.0) / ((sex == "male" ? 0.68 : 0.55) * weight * 1000.0)
                        self.drinksIntake += data.amount / 14
                    }
                    self.bac =  rawBAC - (eliminationRate * deltaFirstDrink)
                    if bac <= 0 {
                        self.bac = 0
                    }
                    
                    self.timeBeforeZero = bac / eliminationRate
                    if bac <= 0 && deltaFirstDrink >= 24 {
                        resetConsumption()
                    }
                    if bac >= 0.08 {
                        drivingConditionIndex = 2
                    } else if bac > 0 {
                        drivingConditionIndex = 1
                    } else {
                        drivingConditionIndex = 0
                    }
                    
                    
                    if let hsManager = hsManager {
                        hsManager.requestAuthorization { success in
                        }
                    }
                    if vm.enableHK {
                        self.sendDataToHK(bac: bac)
                    }
                    if dbFirstTime {
                        showPersonalData.toggle()
                        dbFirstTime = false
                    }
                }
            }
            
            HStack {
                Image(systemName: "person.circle")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
                    .onTapGesture {
                        showPersonalData.toggle()
                    }
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                
                .padding()
            }
        }
        .sheet(isPresented: $showPersonalData) {
            PersonalData()
        }
        .slideOverCard(isPresented: $showBACInfo) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Blood alcohol content (BAC) is the amount of alcohol in your blood.")
                Text("For example, 0.10% BAC means there is 0.10g of alcohol for every 100mL of blood. A BAC of 0.0% means you are sober while a BAC of 0.4% is potentially fatal.")
                Text("Your BAC is calculated using the Widmark formula and depends on the amount of alcohol you have consumned, but also on your weight and sex. This formula is not 100% accurate, but gives you an idea of what your BAC could be based on your consumption and personal data.")
            }
            .frame(maxWidth: .infinity)
        }
        .slideOverCard(isPresented: $showAlcConsumInfo) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Your Alcohol Consumption is measured in standard drinks")
                Text("A standard drink contains 14g of pure alcohol and represents:")
                VStack(alignment: .center){
                    
                    Text("5 fl oz (150mL) of 12% Wine")
                    Text("or")
                    Text("1.5 fl oz (45mL) of 40% Spirit")
                    Text("or")
                    Text("12 fl oz (350mL) of 5% Beer")
                    
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            
        }
        .slideOverCard(isPresented: $showDrivingCondiInfo) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Any amount of alcohol in your blood can impact your driving ability and put you at risk of an accident")
                Text("In the USA, about 29 people die every day because of alcohol-impaired driving. In addition, exceeding a BAC of 0.08% constitutes a criminal offense and can result in legal penalties.")
                Text("Always make sure to have a backup plan such as public transport or a designated driver before you start drinking.")
            }
            .frame(maxWidth: .infinity)
            
        }
    }
    
    struct Dashboard_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                Dashboard()
                Dashboard().preferredColorScheme(.dark)
            }
            .environmentObject(HomeViewModel())
            .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
