//
//  PassionFoodApp.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 26/01/2023.
//

import SwiftUI

@main
struct PassionFoodApp: App {
    @StateObject private var coreDataController = CoreDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // add new modifier into ContentView
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
