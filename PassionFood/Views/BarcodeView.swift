//
//  BarcodeView.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 04/02/2023.
//

//1. TextField - add Barcode
//2. Button trigger Action
//3. Access to ViewModel InfoTable - JSON call

import SwiftUI

struct BarcodeView: View {
    @StateObject var infoTableVM: InfoTableViewModel = InfoTableViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State var sku: String = "" // 3017620422003, 0737628064502
    @State var productFound: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // Title
                HStack {
                    Text("Click \n  Towards  \n     Wisdom")
                        .font(.largeTitle)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(25)
                    Spacer()
                }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 70)
               
                // Barcode input
                TextField("Enter Your Barcode", text: $sku)
                    .frame(height: 45)
                    .disableAutocorrection(true)
                    .background(Color.init(uiColor: .systemGray6))
                    .cornerRadius(10)
                    .padding(20) // move the list up and from edges
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.pink)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 40)
                    .keyboardType(.default)
                
// Group Button and Nav link together + Binding passes into next view
                Group {
                    Button(action: {
                        if sku != "" {
                            self.infoTableVM.sku = sku
                    // Uses 'async' in the method in VM, here View 'await'
                            Task {
                                await infoTableVM.getInfo()
                    // Don't toggle if Error occur??
                                if infoTableVM.errorOccured != true {
                                    productFound.toggle() // for nav link
                                }
                                 sku = "" // clear out TextField
                            }
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 170, height: 55)
                            Text("Scan Me")
                                .foregroundColor(Color.init(uiColor: .systemGray4))
                                .font(.title2)
                                .fontWeight(.regular)
                        }
                    })
                    
                    NavigationLink("", isActive: $productFound) {
                        if let _ = infoTableVM.infoTable {
                            ProductView(infoVM: infoTableVM, productFound: $productFound)
                        }
                    }
                }
                
                Spacer()
            } // end VS
            .alert("Wrong Barcode \(infoTableVM.statusCode)", isPresented: $infoTableVM.errorOccured,
                actions: {
                    Button("Try again") {
                        dismiss()
                    }
            })
            .background(LinearGradient(gradient: Gradient(colors: [.black, .teal]), startPoint: .topTrailing, endPoint: .bottomLeading))
            .edgesIgnoringSafeArea(.all)
        } // end Nav
        .navigationBarBackButtonHidden(true)
      
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}
