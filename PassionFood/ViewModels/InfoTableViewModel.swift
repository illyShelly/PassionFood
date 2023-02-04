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
// 3. Handle success 200 & error - guard, else -> throw or return

@MainActor // Err 1. related

class InfoTableViewModel: ObservableObject {
    @Published var infoTable: InfoTable? // InfoTable struct type
    @Published var sku: String = "" // no need 'init' with defined value
    @Published var errorOccured: Bool = false // toggle NavLink into ProductView
    @Published var statusCode: String = "" // default status, show user what's going on
    
    func getInfo() async {
        /// Initialize JSON decoder when catching data from API
        let decoder = JSONDecoder()
        let url = URL(string: "https://world.openfoodfacts.org/api/v2/product/\(sku)")
        var request = URLRequest(url: url!)
            request.httpMethod = "GET"
        //        Perform request
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let serverResponse = response as? HTTPURLResponse
            guard serverResponse?.statusCode == 200 else {
                statusCode = String(describing: serverResponse?.statusCode)
                errorOccured = true
                print("Error occured: \(String(describing: serverResponse?.statusCode))")
                throw URLError(.badServerResponse)
                // after 'throw' code is not executed (use of 'throw' OR 'return'
            }
            /// Safe way to create stringifyData variable if 'data' aren't nil, instead forcing to unwrapped it '!'
//            if let stringifyData = String(data: data, encoding: .utf8) {
//                print("All JSON: \(stringifyData)") // see all json Openfoodfacts
//            }
            
            infoTable = try decoder.decode(InfoTable.self, from: data) // Err 0., 1.
            
            print("Infotable my struct: \(String(describing: infoTable))") // to silence error
            print("Any error? \(errorOccured)")
        } catch {
            print(error.localizedDescription)
            errorOccured = true
        }
    }
}

// Forgot and stored as constant 'let'= infoTable
// (would create another variable in the memory, not referencing to my @Published var infoTable)
//  Error 1. Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
// The function in the first example is on a different queue that could be on the main thread, but it is not guaranteed so you need to take appropriate action such as suggested or use @MainActor.
