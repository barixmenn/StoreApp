//
//  Constant.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation

final class Constant {
    
    static var development: URL {
            URL(string: "https://api.escuelajs.co")!
        }
        
        static var production: URL {
            URL(string: "https://production.api.escuelajs.co")!
        }
        
        static var `default`: URL {
            #if DEBUG
                return development
            #else
                return production
            #endif
        }
        
        static var allCategories: URL {
            URL(string: "/api/v1/categories", relativeTo: Self.default)!
        }
        
        static func productsByCategory(_ categoryId: Int) -> URL {
            return URL(string: "/api/v1/categories/\(categoryId)/products", relativeTo: Self.default)!
        }
}
