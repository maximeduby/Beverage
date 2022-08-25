//
//  JSONManager.swift
//  Beverage
//
//  Created by Maxime Duby on 26/07/2022.
//
import Foundation

struct DataStructure: Codable, Hashable {
    var name: String
    var id: Int16
    var category: String
    var type: String
    var country: String
    var region: String
    var year: Int16
    var desc: String
    var abv: Double
    var taste: String
    var variety: String
    var foodPairing: String
    
    static let allData: [DataStructure] = Bundle.main.decode(file: "data.json")
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project")
        }
        let decoder = JSONDecoder()
        do {
            let loadedData = try decoder.decode(T.self, from: data)
            return loadedData
        } catch {
            print(error)
            fatalError("Failed to decode \(file) from bundle.")
        }
    }
}
