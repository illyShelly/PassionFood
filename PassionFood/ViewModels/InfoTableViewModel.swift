//
//  InfoTableVM.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 26/01/2023.
//

import Foundation
import SwiftUI

// 0. Create class - to track the changes in a View -> ObservableObject (wrapper in view)
// 1. API call to json object
// 2. Define http request
// 3. Handle success 200 & error

@MainActor // Err 1. related

class InfoTableViewModel: ObservableObject {
    @Published var infoTable: InfoTable? // InfoTable struct type
        
    func getInfo() async {
        let decoder = JSONDecoder()
        let url = URL(string: "https://world.openfoodfacts.org/api/v2/product/3017620422003")
        var request = URLRequest(url: url!)
            request.httpMethod = "GET"
        //        Perform request
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
//            print(response)
            let stringifyData = String(data: data, encoding: .utf8)!
//            print(stringifyData) // see all json Openfoodfacts
            
            // Forgot and stored as constant 'let'= infoTable
            // (would create another variable in the memory, not referencing to my @Published var infoTable)
            infoTable = try decoder.decode(InfoTable.self, from: data) // Err 1.
            
            print("Infotable my JSON struct: \(String(describing: infoTable))") // to silence error
//            print("Url image: \(String(describing: infoTable?.product.image_url))")
        } catch {
            print(error.localizedDescription)
        }
    }
}

//  Error 1. Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
// The function in the first example is on a different queue that could be on the main thread, but it is not guaranteed so you need to take appropriate action such as suggested or use @MainActor.
