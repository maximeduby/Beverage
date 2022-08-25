//
//  HomeViewModel.swift
//  Beverage
//
//  Created by Maxime Duby on 21/07/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var enableHK: Bool = true
}
