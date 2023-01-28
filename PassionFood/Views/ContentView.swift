//
//  ContentView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 26/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var infoViewModel = InfoTableViewModel()
    
    var body: some View {
        VStack {
            // Button("Get Info", action: infoVM.getInfo)
            Spacer()
            
            // Make shorter variable called infoProduct
            if let infoProduct = infoViewModel.infoTable {
                // AsyncImage(url: URL(string: (infoViewModel.infoTable?.product.image_url)!))
                AsyncImage(url: URL(string: (infoProduct.product.image_url)))
                    .scaledToFit()
            } else {
                Text("No Image yet...")
            }
            
            Button {
                Task {
                    await infoViewModel.getInfo()
                    // async in fce (VM), in View await
                }
            } label: {
                Text("Just One Click")
                    .frame(maxWidth: 200)
                    .foregroundColor(.gray)
                    .background(.yellow)
                    .padding(30)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
