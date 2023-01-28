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

struct Product: Encodable {
    var _keywords: [String]
    var image_url: String   // let nutriments: Nutriment
    let nutriments: Nutriment
    
    enum CodingKeys: CodingKey {
        case _keywords, image_url, nutriments
    }
}
extension Product: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
            _keywords =  try container.decode([String].self, forKey: ._keywords)
            if _keywords.contains("gluten-free") {
                _keywords.removeAll { $0 != "gluten-free" }
            }
            image_url = try container.decode(String.self, forKey: .image_url)
            nutriments = try container.decode(Nutriment.self, forKey: .nutriments)
    }
}

struct Info: Codable {  // without manual 'decodable' extention or 'init' -> need to use 'Codable' protocol
    var code: String?
    var status: Int?
    var product: Product?
}

let decoder = JSONDecoder()
let info = try? decoder.decode(Info.self, from: data)

//print(info)
print(info?.status)
print(info?.product?._keywords)
print(info?.product?.nutriments)

