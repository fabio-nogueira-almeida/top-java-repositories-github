//
//  Owner.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

struct Owner {
    let login: String
    let avatarURL: String
}

// MARK: - Decodable

extension Owner: Decodable {
    
    enum OwnerCodingKeys: String, CodingKey {
		case login
        case avatarURL = "avatar_url"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OwnerCodingKeys.self)
        
        login = try container.decode(String.self, forKey: .login)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
    }
}
