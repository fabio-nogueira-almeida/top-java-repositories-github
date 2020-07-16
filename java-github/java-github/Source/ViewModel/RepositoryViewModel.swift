//
//  RepositoryViewModel.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation
import UIKit

import Combine

protocol RepositoryViewModelDelegate {
	func presentPullRequests(for repository: Repository)
}

protocol RepositoryViewModelAPIProtocol {
	func add(model: [Repository])
	func isLastItem(row: Int) -> Bool
	func getname(index: Int) -> String?
	func getDescription(index: Int) -> String?
	func getUsername(index: Int) -> String?
	func getFork(index: Int) -> String
	func getStars(index: Int) -> String
	func getUserImage(index: Int) -> UIImage?
	func numberOfSections() -> Int
	func numberOfItemsInSection() -> Int
	func didSelectItemAt(_ indexPath: IndexPath)
}

class RepositoryViewModel {
	

	
	// MARK: - Property
	
	var delegate: RepositoryViewModelDelegate?
	
	@Published var model = [Repository]()

}

// MARK: - RepositoryViewModelAPIProtocol

extension RepositoryViewModel: RepositoryViewModelAPIProtocol {
	
	func add(model: [Repository]) {
		self.model.append(contentsOf: model)
	}
	
	func isLastItem(row: Int) -> Bool {
		(model.count - 1) == row
	}
	
	func getname(index: Int) -> String? {
		model[index].name
	}
	
	func getDescription(index: Int) -> String? {
		model[index].description
	}
	
	func getUsername(index: Int) -> String? {
		model[index].owner.login
	}
	
	func getFork(index: Int) -> String {
		String(model[index].forks )
	}
	
	func getStars(index: Int) -> String {
		String((model[index].stargazers) )
	}
	
	func getUserImage(index: Int) -> UIImage? {
		let repository = model[index]
		if let url = URL(string: repository.owner.avatarURL) {
			do {
				let imageData = try Data(contentsOf: url)
				return UIImage(data: imageData)
			} catch {
				return nil
			}
		}
		return nil
	}
	
	func numberOfSections() -> Int {
		1
	}
	
	func numberOfItemsInSection() -> Int {
		model.count
	}
	
	func didSelectItemAt(_ indexPath: IndexPath) {
		let repository = model[indexPath.row]
		delegate?.presentPullRequests(for: repository)
	}
}
