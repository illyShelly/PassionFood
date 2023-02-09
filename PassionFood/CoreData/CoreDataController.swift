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
    let container = NSPersistentContainer(name: "Barcodes") // prepare for loading data
    
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
///To create a new Product we need property to access managedobject context from the environment
///-> core data will make it's own class, from inherited parent class NSManagedObject - all those managed objects live inside managed object context - accessible across our app thanks to environment.
///So, @Fetchrequest wrapper knows - looked at man.obj.context and use it for loading and saving (not for .xcdatamodel file). We use another wrapper to access MOC @Environment(\.managedObjectContext) var moc
///To create data -> using Core data class and attached to MOC made for us. let product = Product(context: moc) -> product.id = UUID(), product.name...
///To save -> try? moc.save
