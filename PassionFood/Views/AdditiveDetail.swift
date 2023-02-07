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
        Text("display chemical: \(additive)")
    }
}

struct AdditiveDetail_Previews: PreviewProvider {
    static var previews: some View {
        AdditiveDetail(additive: .constant("E210"))
    }
}
