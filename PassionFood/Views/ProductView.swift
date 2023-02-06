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
            if let _ = infoVM.infoTable {  // a.
                    AsyncImage(url: URL(string: (infoVM.infoTable?.product?.image_url)!))
                        .scaledToFit()
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
