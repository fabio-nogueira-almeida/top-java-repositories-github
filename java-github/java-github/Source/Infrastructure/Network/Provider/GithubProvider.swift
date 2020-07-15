//
//  GithubProvider.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation
import os.log

// MARK: - RepositoryApiResponse

struct RepositoryApiResponse {
    let incompleteResults: Bool
    let totalCount: Int
    let items: [Repository]
}

// MARK: - Decodable

extension RepositoryApiResponse: Decodable {
    
    private enum RepositoryApiResponseCodingKeys: String, CodingKey {
		case items
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepositoryApiResponseCodingKeys.self)
        incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        items = try container.decode([Repository].self, forKey: .items)
        
    }
}

// MARK: - GithubProvider

struct GithubProvider {
	func getJavaRepositories(page: Int, completion: @escaping (_ movie: [Repository]?,
															   _ isLastPage: Bool?,
															   _ error: String?)->()){
			let router = Router<GithubEndPoint>()
			router.request(.repositories(language: "Java", page: page)) { data, response, error in

				if let response = response as? HTTPURLResponse {
					let result = NetworkManager.handleNetworkResponse(response)
	
					switch result {
					case .success:
						guard let responseData = data else {
							completion(nil, nil, NetworkResponse.noData.rawValue)
							return
						}
	
						do {
	
							let apiResponse = try JSONDecoder().decode(RepositoryApiResponse.self,
																	   from: responseData)
							
							os_log("getJavaRepositories - inpleteResults: %@", log: OSLog.api, type: .debug, apiResponse.incompleteResults)
							os_log("getJavaRepositories - totalCount: %@", log: OSLog.api, type: .debug, apiResponse.totalCount)
							os_log("getJavaRepositories - items: %@", log: OSLog.api, type: .debug, apiResponse.items)
							
							completion(apiResponse.items, !apiResponse.incompleteResults, nil)
	
						} catch {
							completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
						}
	
					case .failure(let networkFailureError):
						completion(nil, nil, networkFailureError)
					}
				}
			}
		}
	
	func getPullRequest(repository: String,
						owner: String,
						completion: @escaping (_ pullRequests: [PullRequest]?, _ error: String?)->()) {
			
		let router = Router<GithubEndPoint>()
		
		router.request(.pullRequests(repository: repository, owner: owner)) { data, response, error in

			if let response = response as? HTTPURLResponse {
				let result = NetworkManager.handleNetworkResponse(response)

				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, NetworkResponse.noData.rawValue)
						return
					}

					do {
						let apiResponse = try JSONDecoder().decode([PullRequest].self, from: responseData)
						
						os_log("getPullRequest - items: %@", log: OSLog.api, type: .debug, apiResponse.items)
						
						completion(apiResponse, nil)

					} catch {
						completion(nil, NetworkResponse.unableToDecode.rawValue)
					}

				case .failure(let networkFailureError):
					completion(nil, networkFailureError)
				}
			}
		}
	}
}
