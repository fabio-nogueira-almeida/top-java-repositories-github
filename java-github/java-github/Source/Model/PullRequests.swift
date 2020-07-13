//
//  PullRequests.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

struct PullRequest {
    let title: String
    let body: String
	let html: String
	let user: User
}

// MARK: - Decodable

extension PullRequest: Decodable {
    
    enum PullRequestCodingKeys: String, CodingKey {
		case title, body, user
		case html = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PullRequestCodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
		html = try container.decode(String.self, forKey: .html)
		user = try container.decode(User.self, forKey: .user)
    }
}
