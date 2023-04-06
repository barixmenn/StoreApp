//
//  NetworkManager.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation

final class NetworkManager {
    
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
}
