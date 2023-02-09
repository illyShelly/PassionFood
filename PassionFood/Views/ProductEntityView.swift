//
//  ProductEntityView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 08/02/2023.
//

import SwiftUI

struct ProductEntityView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var storedProducts:FetchedResults<ProductEntity>
    @FetchRequest(sortDescriptors: []) var storedNutriment:FetchedResults<NutrimentEntity>

    @Binding var barcode: String
    @Binding var currentProduct: ProductEntity
  
    
    var body: some View {
        VStack {
            // Show picture
            AsyncImage(url: URL(string: currentProduct.image!)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } placeholder: {
                ProgressView() // default showing uploading
            }
            
//            Text("Energy \(String(format: "%.0f", nutriments.energy))")
            Text("Carbo \(String(format: "%.0f", (currentProduct.nutriments?.carbo)!))")
            
            if let allAdditives = currentProduct.additives?.allObjects as?  [AdditiveEntity] {
                ForEach(allAdditives) { additive in
                    Text(additive.name ?? "e")

                }
            }
            Text("finish")
        }
    }
}
//
//struct ProductEntityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductEntityView(barcode: .constant("8852018101024"), currentProduct: .constant(ProductEntity()))
////            .environment(\.managedObjectContext, coreDataController.container.viewContext)
//    }
//}
