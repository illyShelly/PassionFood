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
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var storedProducts:FetchedResults<ProductEntity> // collection of results retrieved from coredata store
    @FetchRequest(sortDescriptors: []) var storedNutriments:FetchedResults<NutrimentEntity> // collection of results retrieved from coredata store
    @FetchRequest(sortDescriptors: []) var storedAdditives:FetchedResults<AdditiveEntity> // collection of results retrieved from coredata store

    
    @FocusState var skuIsFocused: Bool
    @State var productFound: Bool = false

    @State var barcode: String = "" // 301 76 204 22 003, 0737628064502, 8852018101024
    @State var currentProduct: ProductEntity
    
    var body: some View {
        NavigationView {
            VStack {
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
                       // 2nd title
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
                TextField("Enter Barcode", text: $barcode)
                    .modifier(TextfieldModifier())
//              To dismiss keyboard when going back from Navlink
                    .focused($skuIsFocused)

                
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
                                    
                                    // Check if product is already in DB or create a new
                                    if isProductInDB(barcode: barcode) == false {
                                        createProduct()
                                        print("Products count: \(storedProducts.count)")
                                    }
                                    currentProduct = foundProduct(sku: barcode)
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
//                            ProductView(infoVM: infoTableVM, productFound: $productFound)
                        ProductEntityView(barcode: $barcode, currentProduct: $currentProduct)
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
    
    func foundProduct(sku: String) -> ProductEntity {
        for product in storedProducts {
            if product.code == sku {
                print("Found Product \(product)")
                return product
            }
        }
        print("productFound doesn't match")
        return ProductEntity(context: moc)
    }
    
    func isProductInDB(barcode: String) -> Bool {
        // Check if 'barcode' is alredy in core data
        // *
        for product in storedProducts {
            if product.code == barcode {
                print("isProductInDB \(product.code == barcode), barcode: \(barcode)")
                return true
            }
        }
        print("isProductInDB - false, barcode: \(barcode)")
        return false
    }
    
    func createProduct() {
        let newProduct = ProductEntity(context: moc)
        
        if let data = infoTableVM.infoTable { // avoid optional for infoTable?.product...
            newProduct.code = data.code
            newProduct.image = data.product.image_url
            newProduct.name = data.product.product_name
            newProduct.brand = data.product.brands
            if data.product._keywords.contains("gluten-free") {
                newProduct.glutenFree = true
            } else {
                newProduct.glutenFree = false
            }
            print("Product was created")
//            
            // Fill table with nutriments
            let newNutriment = NutrimentEntity(context: moc)
            newNutriment.carbo = data.nutriments.carbohydrates
            newNutriment.fat = data.nutriments.fat
            newNutriment.proteins = data.nutriments.proteins
            newNutriment.salt = data.nutriments.salt
            newNutriment.energy = data.nutriments.energy
            newNutriment.product = newProduct // one-to-one
            
            print("Nutriment was created")
// if NSSet -> means has many products/additives etc.

//            // Fill & create table with additives if there are any for the Product
            if data.product.additives_tags != [] {
//                print(data.product.additives_tags)
            for chemical in data.product.additives_tags {
//                print(chemical)
                let newAdditive = AdditiveEntity(context: moc)
                    newAdditive.name = chemical
                
                //newAdditive.products?.adding(newProduct)
//                newProduct.additives?.adding(newAdditive)
                newProduct.addToAdditives(newAdditive)
                newAdditive.addToProducts(newProduct)
//                newAdditive.products?.adding(newAdditive)
                
                saveProduct()

            }
            }
            //= newProduct.additives // one-to-many
            print("Additive was created")
        }
        saveProduct()
        print("Additive was created")
        print("printed saved product \(newProduct)")
    }
    
    func saveProduct() {
        // save back into moc
        do {
            try moc.save()
        } catch {
            let err = error as NSError
            fatalError("Unable to save into DB \(err), \(err.userInfo)")
        }
        
    }
    
}

struct TextfieldModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 45)
            .disableAutocorrection(true)
            .background(Color.init(uiColor: .systemGray4))
            .cornerRadius(5)
            .padding(20) // move the list up and from edges
            .multilineTextAlignment(.center)
            .font(.title3)
//                .font(.custom("Open Sans", size: 12))
            .fontWeight(.light)
            .foregroundColor(.pink)
            .padding(.vertical, 30)
            .padding(.horizontal, 40)
            .keyboardType(.decimalPad) // cannot return just on 1st

    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView(currentProduct: ProductEntity())
    }
}


// Do not use so much padding - otherwise make white space when back to 1st screen
// * Static method 'buildBlock' requires that 'Bool' conform to 'AccessibilityRotorContent'
