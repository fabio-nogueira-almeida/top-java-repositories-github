//
//  PullRequestBusiness.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 14/07/20.
//

import Foundation

protocol PullRequestBusinessDelegate: NSObject {
	func dataFetched(items: [PullRequest]?)
}

class PullRequestBusiness {
	
	// MARK: - Property
	
	weak var delegate: PullRequestBusinessDelegate?
	var repository: Repository
	
	private var page = 0
	private var isLastPage = false
	
	// MARKL: - Initialize
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	// MARK: - Public
	
	func fetchData() {
		let provider = GithubProvider()
		
		if !isLastPage {
			
			
			provider.getPullRequest(repository: repository.name,
									owner: repository.owner.login) { results, error in
//				self.isLastPage = isLastPage ?? false
//				self.page += 1
				self.delegate?.dataFetched(items: results)
			}
		}
	}
}

