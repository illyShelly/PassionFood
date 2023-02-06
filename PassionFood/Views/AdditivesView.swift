//
//  AdditivesView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 05/02/2023.
//

import SwiftUI

struct AdditivesView: View {
    @ObservedObject var infoVM: InfoTableViewModel
    @State var additiveFound: Bool = false
    @State var chemical: String = "" // when defined no need to pass from previous :)
    
//    var additives: [String] = ["en:e296", "en:e297xx", "en:e298", "en:e299", "en:e300", "en:e301"]
    
    var body: some View {
        let cols = [GridItem(.fixed(90)), GridItem(.fixed(90)), GridItem(.fixed(90))]
        
        if let additives = infoVM.infoTable?.product.additives_tags {
//                Create rows
            LazyVGrid(columns: cols, alignment: .center, spacing: 15) {
                ForEach(additives, id: \.self) { additive in

                // Create button for each additive
                    Group {
                        Button(additive[3..<7].uppercased(), action: {
                            //
                            additiveFound = true
                            chemical = additive
                        })
                        NavigationLink("", isActive: $additiveFound) {
                            AdditiveDetail(additive: $chemical)
                        }
                    }
                    
                }
            }
        }
       
    }
}

struct AdditivesView_Previews: PreviewProvider {
    static var previews: some View {
        AdditivesView(infoVM: InfoTableViewModel(), chemical: "E210")
    }
}
