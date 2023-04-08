//
//  Product.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation

struct Product: Codable {
    var id: Int?
    let title: String
    let price: Double
    let description: String
    let images: [URL]?
    let category: Category
}
