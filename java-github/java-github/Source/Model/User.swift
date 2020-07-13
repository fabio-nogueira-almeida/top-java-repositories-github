//
//  User.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

struct User {
    let username: String
    let avatarURL: String
}

// MARK: - Decodable

extension User: Decodable {
    
    enum UserCodingKeys: String, CodingKey {
		case username = "login"
        case avatarURL = "avatar_url"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        username = try container.decode(String.self, forKey: .username)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
    }
}
