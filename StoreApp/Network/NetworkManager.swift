//
//  NetworkManager.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation

final class NetworkManager {
    
    /// category 
    func getAllCategories() async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: Constant.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw ErrorType.invalidServerResponse
        }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw ErrorType.decodingError
        }
        
        return categories
    }
    
    /// product
    func getProductsByCategory(categoryId: Int) async throws -> [Product] {
        
        let (data, response) = try await URLSession.shared.data(from: Constant.productsByCategory(categoryId))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw ErrorType.invalidServerResponse
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw ErrorType.decodingError
        }
        
        return products
    }
    
    /// add product
    func createProduct(productRequest: CreateProduct) async throws -> Product {
        
        var request = URLRequest(url: Constant.createProduct)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(productRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201
        else {
            throw ErrorType.invalidServerResponse
        }
        
        guard let product = try? JSONDecoder().decode(Product.self, from: data) else {
            throw ErrorType.decodingError
        }
        
        return product
    }
    
}
