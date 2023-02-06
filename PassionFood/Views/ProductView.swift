//
//  ProductView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 04/02/2023.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var infoVM: InfoTableViewModel
    @Binding var productFound: Bool
        
    var body: some View {
//        ScrollView {
            VStack {  // alignment: .center, spacing: 20
                if let product = infoVM.infoTable?.product {  // a.
                    HStack {
                        AsyncImage(url: URL(string: (product.image_url)))
                                    .scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                    }

                    Text(product.product_name)
                    Text(product.brands)
                    Spacer()
                    if let arrGlutenInfo = product._keywords {
                        ForEach(arrGlutenInfo, id: \.self) { item in
                            VStack {
                                Text("Keywords: \(item)")
                            }
                        }
                    }

                    if let nutriments = infoVM.infoTable?.nutriments {
                        VStack {
                            Text("Energy \(String(format: "%.0f", nutriments.energy))")
                            Text("Carbo \(String(format: "%.1f", nutriments.carbohydrates))")
                            Text("Fat \(String(format: "%.1f", nutriments.fat))")
                            Text("Protein \(String(format: "%.1f", nutriments.proteins))")
                            Text("Salt \(String(format: "%.1f", nutriments.salt))")
                        }
                    }

                    // Display all additives if any
                    if var _ = product.additives_tags {
                        AdditivesView(infoVM: infoVM)
                    }
                }
                
            }
              
        }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(infoVM: InfoTableViewModel(), productFound: .constant(true))
    }
}


// AsyncImage(url: URL(string: (productVM.infoTable?.product.image_url)!))
// a. Secure handling of 'optionals' -> if let -> if assigned means API call was successful, InfoTable created
