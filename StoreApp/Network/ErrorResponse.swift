//
//  ErrorResponse.swift
//  StoreApp
//
//  Created by Baris on 6.04.2023.
//

import Foundation

enum ErrorType: Error {
case invalidURL
case invalidServerResponse
case decodingError
}
