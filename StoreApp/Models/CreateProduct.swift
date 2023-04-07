//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by Baris on 8.04.2023.
//

import Foundation
struct CreateProduct: Encodable {
    
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]
    
    init(product: Product) {
        title = product.title
        price = product.price
        description = product.description
        categoryId = product.category.id
        images = product.images ?? []
    }
    
}
