//
//  RepositoryBusiness.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 14/07/20.
//

import Foundation

protocol RepositoryBusinessDelegate: NSObject {
	func dataFetched(items: [Repository]?)
}

class RepositoryBusiness {
	
	// MARK: - Property
	
	weak var delegate: RepositoryBusinessDelegate?
	private var page = 0
	private var isLastPage = false
	
	// MARK: - Public
	
	func fetchData() {
		let provider = GithubProvider()
		if isLastPage == false {
			provider.getJavaRepositories(page: page) { repositories, isLastPage, error in
				self.isLastPage = isLastPage ?? false
				self.page += 1
				self.delegate?.dataFetched(items: repositories)
			}
		}
	}
}
