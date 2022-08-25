//
//  PersonalData.swift
//  Beverage
//
//  Created by Maxime Duby on 23/08/2022.
//

import SwiftUI

struct PersonalData: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("sex") var sex: String = "male"
    @AppStorage("weight") var weight: Double = 70.0
    
    var body: some View {
        ZStack{
            VStack{
                Text("Personal Data")
                    .font(.title)
                    .bold()
                    .padding()
                List{
                    Section(header: Text("Personal Data")){
                        HStack {
                            Text("Sex")
                            Spacer()
                            Picker("Sex", selection: $sex) {
                                Text("Male")
                                    .tag("male")
                                Text("Female")
                                    .tag("female")
                            }
                            .pickerStyle(.menu)
                            .padding(.horizontal)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        
                        }
                        .listRowBackground(Color("bgd"))
                        HStack {
                            Text("Weight")
                            Spacer()
                            Picker("Weight", selection: $weight) {
                                ForEach(0...500, id: \.self) {
                                    Text(String(Double($0)) + "kg")
                                        .tag(Double($0))
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(.horizontal)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        }
                        .listRowBackground(Color("bgd"))
                    }
                    Section(header: Text("Access"), footer: Text(vm.enableHK ? "⚠️ To send data to the Health App, make sure you have authorized the access in Settings > Privacy > Health > Beverage ." : "")){
                        Toggle("Send Data to Health App", isOn: $vm.enableHK)
                            .listRowBackground(Color("bgd"))
                    }
                    
                }
                
            }
            .background(Color(.systemGroupedBackground))
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

struct PersonalData_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonalData()
            PersonalData().preferredColorScheme(.dark)
        }
        .environmentObject(HomeViewModel())
    }
}
