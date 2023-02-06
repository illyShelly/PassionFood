//
//  Extention.swift
//  PassionFood
//
//  Created by Ilona Sellenberkova on 06/02/2023.
//

import Foundation

extension String {
    subscript (range: Range<Int>) -> String {
      let start = index(startIndex, offsetBy: range.lowerBound)
      let end = index(startIndex, offsetBy: range.upperBound)
      return String(self[start ..< end])
    }    
}
