//
//  AdditiveEntity+CoreDataProperties.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 09/02/2023.
//
//

import Foundation
import CoreData


extension AdditiveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdditiveEntity> {
        return NSFetchRequest<AdditiveEntity>(entityName: "AdditiveEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension AdditiveEntity {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductEntity)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductEntity)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension AdditiveEntity : Identifiable {

}
