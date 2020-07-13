//
//  NetworkManager.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

// MARK: - Enum

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case production
}

// MARK: - NetworkManager

struct NetworkManager {
	
	// MARK: - Property
	
    static let environment : NetworkEnvironment = .production
    static let APIKey = ""
	
	// MARK: - Public
	
	public static func environmentBaseURL() -> String {
        switch NetworkManager.environment {
        case .production:
			return "https://api.github.com/"
        }
    }
	
	static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299:
			return .success
        
		case 401...500:
			return .failure(NetworkResponse.authenticationError.rawValue)
			
        case 501...599:
			return .failure(NetworkResponse.badRequest.rawValue)
			
        case 600:
			return .failure(NetworkResponse.outdated.rawValue)
			
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
	
}

