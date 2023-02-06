//
//  ProductModel.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 05/02/2023.
//

import Foundation

struct ProductModel {
    let name: String
    let brand: String
    let image: String
    let keywords: [String]
    let additives: [String]
    let nutriments: Nutriment
}


//struct Nutriment: {
//    let carbohydrates: Double
//    let energy: Double
//}
