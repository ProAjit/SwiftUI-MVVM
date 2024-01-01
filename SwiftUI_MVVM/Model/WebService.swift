//
//  WebService.swift
//  SwiftUI_MVVM
//
//  Created by Ajit Satarkar on 20/11/23.
//

import Foundation

struct APIEndpoints {
    static let usersURLString = "https://api.github.com/users"
}

final class WebService {
    
    static func getUsersData() async throws -> [UserModel] {
        guard let url = URL(string: APIEndpoints.usersURLString) else {
            throw UserError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UserError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([UserModel].self, from: data)
        } catch {
            throw UserError.invalidData
        }
    }
    
}


enum UserError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid data"
            
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
