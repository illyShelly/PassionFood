import UIKit

let jsonString = "{\"code\": \"0737628064502\", \"product\": { \"_keywords\": [\"gluten-free\", \"plant-based\", \"cereal\"],\"image_url\": \"https://images.openfoodfacts.org/images/products/073/762/806/4502/front_en.6.400.jpg\", \"nutriments\": {\"carbohydrates\": 71.15,\"energy\": 385}}, \"status\": 1}"
// print(jsonString)
// {"code": "0737628064502", "product": { "_keywords": ["gluten-free", "plant-based"],"image_url": "https://images.openfoodfacts.org/images/products/073/762/806/4502/front_en.6.400.jpg", "nutriments": {"carbohydrates": 71.15,"energy": 385}}, "status": 1}

let data = Data(jsonString.utf8)

func printJson(data: Data) {
    print(try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
}

//print(printJson(data: data))
//Optional({
//    code = 0737628064502;
//    product =     {
//        "_keywords" =         (
//            "gluten-free",
//            "plant-based"
//        );
//        "image_url" = "https://images.openfoodfacts.org/images/products/073/762/806/4502/front_en.6.400.jpg";
//        nutriments =         {
//            carbohydrates = "71.15000000000001";
//            energy = 385;
//        };
//    };
//    status = 1;
//})
//()

struct Nutriment: Codable {
    let carbohydrates: Double
    let energy: Double
}

struct Product: Codable {
    var _keywords: [String]
    var image_url: String   // let nutriments: Nutriment
//    let nutriments: Nutriment
    
    enum CodingKeys: CodingKey {
        case _keywords, image_url //, nutriments
    }
//    init(from decoder: Decodable) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        _keywords =  try container.decode([String].self, forKey: ._keywords)
//        image_url = try container.decode(String.self, forKey: .image_url)
//        nutriments = try container.decode(Nutriment.self, forKey: .nutriments)
//    }
}

struct Info: Encodable {  // without manual 'decodable' extention or 'init' -> need to use 'Codable' protocol
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
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//         code =  try container.decode(String.self, forKey: .code)
//        status = try container.decode(Int.self, forKey: .status)
//        product = try container.decode(Product.self, forKey: .product)
//        let nestedContainer = try container.nestedContainer(keyedBy: NutrimentsKeys.self, forKey: .product)
//        nutriments = try nestedContainer.decode(Nutriment.self, forKey: .nutriments)
//    }
}
extension Info: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        status = try container.decode(Int.self, forKey: .status)
        product = try container.decode(Product.self, forKey: .product)
            if product._keywords.contains("gluten-free") {
                product._keywords.removeAll { $0 != "gluten-free" }
            }
        let nutrimentsContainer = try container.nestedContainer(keyedBy: NutrimentsKeys.self, forKey: .product)
        nutriments = try nutrimentsContainer.decode(Nutriment.self, forKey: .nutriments)
    }
}


let decoder = JSONDecoder()
let info = try? decoder.decode(Info.self, from: data)

print(info)
print(info?.status)
print(info?.product.image_url) // Optional("https://images.openfoodfacts.org/images/products/073/762/806/4502/front_en.6.400.jpg")
print(info?.product._keywords)
print(info?.nutriments) // Optional(__lldb_expr_88.Nutriment(carbohydrates: 71.15, energy: 385.0))
print(info?.nutriments.carbohydrates)
