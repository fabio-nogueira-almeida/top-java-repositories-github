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
	
	// MARKL: - Initialize
	
	init(repository: Repository) {
		self.repository = repository
	}
	
	// MARK: - Public
	
	func fetchData() {
		let provider = GithubProvider()
			provider.getPullRequest(repository: repository.name,
									owner: repository.owner.login) { results, error in
				self.delegate?.dataFetched(items: results)
			}
	}
}

