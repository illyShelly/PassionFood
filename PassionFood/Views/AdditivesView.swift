//
//  AdditivesView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 05/02/2023.
//

import SwiftUI

struct AdditivesView: View {
    @ObservedObject var infoVM: InfoTableViewModel
    
//    var additives: [String] = ["en:e296", "en:e297", "en:e298", "en:e299", "en:e300", "en:e301"]
//    @Binding var additives: [String]
    
    var body: some View {
        let cols = [GridItem(.fixed(90)), GridItem(.fixed(90)), GridItem(.fixed(90))]
        
        if let additives = infoVM.infoTable?.product.additives_tags {
//                Create rows
            LazyVGrid(columns: cols, alignment: .center, spacing: 15) {
                ForEach(additives, id: \.self) { additive in
                    
                    // Create button for each additive
//                    NavigationLink(value: additive) {
//                        Label("Row \(i)", systemImage: "\(i).circle")
                        Button(additive, action: {
//                            AdditiveDetail()
                        })
//                    }
                    
                }

            }
        }
       
    }
}

struct AdditivesView_Previews: PreviewProvider {
    static var previews: some View {
        AdditivesView(infoVM: InfoTableViewModel())
    }
}
