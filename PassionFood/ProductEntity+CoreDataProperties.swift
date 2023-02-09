//
//  ProductEntity+CoreDataProperties.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 09/02/2023.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var brand: String?
    @NSManaged public var code: String?
    @NSManaged public var glutenFree: Bool
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var additives: NSSet?
    @NSManaged public var nutriments: NutrimentEntity?

}

// MARK: Generated accessors for additives
extension ProductEntity {

    @objc(addAdditivesObject:)
    @NSManaged public func addToAdditives(_ value: AdditiveEntity)

    @objc(removeAdditivesObject:)
    @NSManaged public func removeFromAdditives(_ value: AdditiveEntity)

    @objc(addAdditives:)
    @NSManaged public func addToAdditives(_ values: NSSet)

    @objc(removeAdditives:)
    @NSManaged public func removeFromAdditives(_ values: NSSet)

}

extension ProductEntity : Identifiable {

}
