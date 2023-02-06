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
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                if let product = infoVM.infoTable?.product {  // a.
                    
                    AsyncImage(url: URL(string: product.image_url)) { image in image.resizable()
                    } placeholder: {
                        ZStack {
                            Color.init(uiColor: .systemGray6)
                            Text("Uploading")
                        }
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    VStack(alignment: .center, spacing: 30) {
                        Text(infoVM.infoTable!.code)
                        Text(product.product_name)
                        Text(product.brands)
                        
                        if let arrGlutenInfo = product._keywords {
                            ForEach(arrGlutenInfo, id: \.self) { item in
                                VStack {
                                    Text("keywords:")
                                    Text(item)
                                }
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
                
            } // VS
            
        } // Scroll

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(infoVM: InfoTableViewModel(), productFound: .constant(true))
    }
}


// AsyncImage(url: URL(string: (productVM.infoTable?.product.image_url)!))
// a. Secure handling of 'optionals' -> if let -> if assigned means API call was successful, InfoTable created
