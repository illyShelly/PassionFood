//
//  AdditiveDetail.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 05/02/2023.
//

import SwiftUI

struct AdditiveDetail: View {
    @Binding var additive: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AdditiveDetail_Previews: PreviewProvider {
    static var previews: some View {
        AdditiveDetail(additive: .constant("E210"))
    }
}
