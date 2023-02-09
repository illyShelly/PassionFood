//
//  AdditiveDetail.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 05/02/2023.
//

import SwiftUI
import CoreData

struct AdditiveDetail: View {
    @Binding var additive: String
    
    var body: some View {
        Text("display chemical: \(additive)")
    }
}

struct AdditiveDetail_Previews: PreviewProvider {
    static var previews: some View {
        AdditiveDetail(additive: .constant("E210"))
    }
}
//
////
////// MARK: Generated accessors for additives
//extension ProductEntity {
//
//    @objc(addAdditivesObject:)
//    @NSManaged public func addToAdditives(_ value: AdditiveEntity)
//
//    @objc(removeAdditivesObject:)
//    @NSManaged public func removeFromAdditives(_ value: AdditiveEntity)
//
//    @objc(addAdditives:)
//    @NSManaged public func addToAdditives(_ values: NSSet)
//
//    @objc(removeAdditives:)
//    @NSManaged public func removeFromAdditives(_ values: NSSet)
//
//}
