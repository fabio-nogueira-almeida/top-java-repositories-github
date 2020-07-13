//
//  GitHubEndPoint.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

// MARK: - GithubEndPoint

public enum GithubEndPoint {
	case repositories(language:String, page: Int)
	case pullRequests(repository: String, owner: String)
}

// MARK: - EndPointProtocol

extension GithubEndPoint: EndPointProtocol {
    	
    var path: String {
        switch self {
        case .repositories(let language, let page):
            return "search/repositories?q=language:\(language)&sort=stars&page=\(page)/"
        
		case .pullRequests(let repository, let owner):
            return "repos/\(owner)/\(repository)/pulls"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
