//
//  PullRequestViewModel.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 14/07/20.
//

import Foundation
import UIKit

protocol PullRequestViewModelAPIProtocol {
	func add(model: [PullRequest])
	func isLastItem(row: Int) -> Bool
	func getTitle(index: Int) -> String?
	func getDescription(index: Int) -> String?
	func getUserName(index: Int) -> String?
	func getUserImage(index: Int) -> UIImage?
	func numberOfSections() -> Int
	func numberOfItemsInSection() -> Int
}

class PullRequestViewModel {
	
	// MARK: - Property
	
	private var model = [PullRequest]()
}

// MARK: - RepositoryViewModelAPIProtocol

extension PullRequestViewModel: PullRequestViewModelAPIProtocol {

	func add(model: [PullRequest]) {
		self.model.append(contentsOf: model)
	}
	
	func isLastItem(row: Int) -> Bool {
		(model.count - 1) == row
	}
	
	func getTitle(index: Int) -> String? {
		model[index].title
	}
	
	func getDescription(index: Int) -> String? {
		model[index].body
	}
	
	func getUserName(index: Int) -> String? {
		model[index].user.username
	}
	
	func getUserImage(index: Int) -> UIImage? {
		let pullrequest = model[index]
		if let url = URL(string: pullrequest.user.avatarURL) {
			do {
				let imageData = try Data(contentsOf: url)
				return UIImage(data: imageData)
			} catch {
				return nil
			}
		}
		return nil
	}
	
	func numberOfItemsInSection() -> Int {
		model.count
	}
	
	func numberOfSections() -> Int {
		1
	}
}

