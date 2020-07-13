//
//  Github.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

// MARK: - Repository

struct Repository {
    let id: Int
    let name: String
    let description: String
    let forks: Int
    let stargazers: Int
    let owner: Owner
}

// MARK: - Decodable

extension Repository: Decodable {
    
    enum RepositoryCodingKeys: String, CodingKey {
		case id, name, description, forks, owner
        case stargazers = "stargazers_count"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepositoryCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        forks = try container.decode(Int.self, forKey: .forks)
        owner = try container.decode(Owner.self, forKey: .owner)
        stargazers = try container.decode(Int.self, forKey: .stargazers)
    }
}
