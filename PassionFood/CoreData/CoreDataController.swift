//
//  CoreDataController.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 07/02/2023.
//

import CoreData
import Foundation

class CoreDataController: ObservableObject {
    // single property type NSpersistence container - Core Data type to loading model & access data inside
    let container = NSPersistentContainer(name: "BarcodePersistence") // prepare for loading data
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    } // it loads persistence store when controller is created
}

///Last step:
///make instance of coredatacontroller and send it into swiftUI environment - App main
