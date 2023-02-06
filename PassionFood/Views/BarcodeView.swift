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
    
    @State var barcode: String = "" // 3017620422003, 0737628064502, 8852018101024
    @State var productFound: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
// Title & Slogan
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
                    .padding(.top, 70)
                    .padding(.bottom, 50)
               
// Input for Barcode
                TextField("Enter Barcode", text: $barcode)
                    .frame(height: 45)
                    .disableAutocorrection(true)
                    .background(Color.init(uiColor: .systemGray6))
                    .cornerRadius(10)
                    .padding(20) // move the list up and from edges
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.pink)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 40)
                    .keyboardType(.default)
                
// Group Button & Nav link + Binding to pass into ProductView
                Group {
                    Button(action: {
                        if barcode != "" {
                            self.infoTableVM.barcode = barcode
        // Uses 'async' in the method in VM, here View 'await'
                            Task {
                                await infoTableVM.getInfo()
        // Don't toggle 'productFound' when Error occur??
                                if infoTableVM.errorOccured != true {
                                    productFound.toggle() // for nav link
                                    barcode = ""
                                }
                            //sku = "" // clear out TextField
                            }
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 170, height: 55)
                            Text("Scan Me".uppercased())
                                .foregroundColor(Color.init(uiColor: .systemGray6))
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
            
// Pop-up alert if anything goes wrong to User
            .alert("Wrong Barcode \(infoTableVM.statusCode)", isPresented: $infoTableVM.errorOccured,
                actions: {
                    Button("Try again") {
                        dismiss()
                    }
            })
// Background colour for whole screen
            .background(LinearGradient(
                gradient: Gradient(colors: [.black, .mint]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading))
            .edgesIgnoringSafeArea(.all)
        } // end Nav
//        .navigationBarBackButtonHidden(true)
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}
