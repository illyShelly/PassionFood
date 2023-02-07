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
    
    @State var barcode: String = "" // 301 76 204 22 003, 0737628064502, 8852018101024
    @State var productFound: Bool = false
    @FocusState var skuIsFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack { //(alignment: .center)
// Title & Slogan
                Spacer()
                VStack {
                        HStack {
                            Text("Scan")
                                .fontWeight(.thin)
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .opacity(0.45)
                            Spacer()
                        }
//                        // 2nd title
                        HStack {
                            Spacer()
                            Text("Towards")
                                .fontWeight(.thin)
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                                .opacity(0.69)
                            Spacer()
                        }
                        .padding(.trailing, 60)
                        // 3rd title
                        HStack {
                            Spacer()
                            Text("Wisdom")
                                .fontWeight(.thin)
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                                .opacity(0.82)
                        }

                } // title
                .padding(.horizontal, 30)
//                .padding(.top, 60) // make empty white space under the backround

                // Input for Barcode
                VStack {
                    TextField("Enter Barcode", text: $barcode)
                        .frame(height: 45)
                        .disableAutocorrection(true)
                        .background(Color.init(uiColor: .systemGray4))
                        .cornerRadius(5)
                        .padding(20) // move the list up and from edges
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.pink)
                        .padding(.vertical, 30)
                        .padding(.horizontal, 40)
//                        .keyboardType(.decimalPad)
//                    To dismiss keyboard when going back from Navlink
                        .focused($skuIsFocused)

                }
                
// Group Button & Nav link + Binding to pass into ProductView
                Group {
                    Button(action: {
                        if barcode != "" {
                            self.infoTableVM.barcode = barcode
        // Uses 'async' in the method in VM, here View 'await'
                            Task {
                                await infoTableVM.getInfo()
        // When product found, no 'error'
                                if infoTableVM.errorOccured != true {
                                    productFound.toggle() // for nav link
                                }
                                barcode = ""
                            }
                        }
                        skuIsFocused = false // set false again for keyboard up
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
//                                .opacity(0.9)
                                .frame(width: 170, height: 55)
                            Text("Send")
                                .foregroundColor(.white)
                                .opacity(0.85)
                                .font(.title2)
                                .fontWeight(.regular)
                        }
                    })
                    .padding(.bottom, 45)
                    
                    NavigationLink("", isActive: $productFound) {
                        if let _ = infoTableVM.infoTable {
                            ProductView(infoVM: infoTableVM, productFound: $productFound)
                        }
                    }
                }
                Spacer()
                Spacer()
            } // end VS
            
// Background colour for whole screen
            .background(LinearGradient(gradient: Gradient(colors: [.black, .mint]), startPoint: .topTrailing, endPoint: .bottomLeading))
            .edgesIgnoringSafeArea(.all) // before ending Nav
            
// Pop-up alert if anything goes wrong to User
            .alert("Wrong Barcode \(infoTableVM.statusCode)", isPresented: $infoTableVM.errorOccured,
                actions: {
                    Button("Try again") {
                        dismiss()
                    }
            })

        } // end Nav
        .navigationBarBackButtonHidden(true)

    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}


// Do not use so much padding - otherwise make white space when back to 1st screen
