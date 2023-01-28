//
//  InfoTable.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 26/01/2023.
//

import Foundation

struct Nutriment: Codable {
    let carbohydrates: Double
    let energy: Double
}

struct Product: Codable {
    var _keywords: [String]
    var image_url: String
}

struct InfoTable: Encodable {  // without manual 'decodable' extention or 'init' -> need to use 'Codable' protocol
    var code: String
    var status: Int
    var product: Product
    let nutriments: Nutriment

    enum CodingKeys: CodingKey {
        case code, status, product
    }
    enum NutrimentsKeys: CodingKey {
        case nutriments
    }
}

extension InfoTable: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        status = try container.decode(Int.self, forKey: .status)
        product = try container.decode(Product.self, forKey: .product)
        // Delete all strings beside the 'gluten-free'
            if product._keywords.contains("gluten-free") {
                product._keywords.removeAll { $0 != "gluten-free" }
            }
        let nutrimentsContainer = try container.nestedContainer(keyedBy: NutrimentsKeys.self, forKey: .product)
        nutriments = try nutrimentsContainer.decode(Nutriment.self, forKey: .nutriments)
        
    }
}
