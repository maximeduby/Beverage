//
//  UIApplication.swift
//  Beverage
//
//  Created by Maxime Duby on 22/07/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
