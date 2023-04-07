//
//  String+Extensions.swift
//  StoreApp
//
//  Created by Baris on 8.04.2023.
//

import Foundation

extension String {
    
    var isNumeric: Bool {
        Double(self) != nil
    }
    
}
