//
//  NutrimentEntity+CoreDataProperties.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 10/02/2023.
//
//

import Foundation
import CoreData


extension NutrimentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutrimentEntity> {
        return NSFetchRequest<NutrimentEntity>(entityName: "NutrimentEntity")
    }

    @NSManaged public var carbo: Double
    @NSManaged public var energy: Double
    @NSManaged public var fat: Double
    @NSManaged public var proteins: Double
    @NSManaged public var salt: Double
    @NSManaged public var product: ProductEntity?

}

extension NutrimentEntity : Identifiable {

}
