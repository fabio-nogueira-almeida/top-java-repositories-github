//
//  RepositoryViewModel.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation
import UIKit

protocol RepositoryAPIProtocol {
	func getname(index: Int) -> String?
	func getDescription(index: Int) -> String?
	func getUsername(index: Int) -> String?
	func getFork(index: Int) -> String
	func getStars(index: Int) -> String
	func getUserImage() -> UIImage
	func numberOfSections() -> Int
	func numberOfItemsInSection() -> Int
}

struct RepositoryViewModel {
	
	// MARK: - Property
	
	private var model = [Repository]()
	
	// MARK: - Private
	
	// MARK: - Public
	
	mutating func add(model: [Repository]) {
		self.model.append(contentsOf: model)
	}
	
	func isLastItem(row: Int) -> Bool {
		(model.count - 1) == row
	}
}

// MARK: - RepositoryAPIProtocol

extension RepositoryViewModel: RepositoryAPIProtocol {
	func getname(index: Int) -> String? {
		model[index].name
	}
	
	func getDescription(index: Int) -> String? {
		model[index].description
	}
	
	func getUsername(index: Int) -> String? {
		model[index].name
	}
	
	func getFork(index: Int) -> String {
		String(model[index].forks )
	}
	
	func getStars(index: Int) -> String {
		String((model[index].stargazers) )
	}
	
	func getUserImage() -> UIImage {
		UIImage()
	}
	
	func numberOfSections() -> Int {
		1
	}
	
	func numberOfItemsInSection() -> Int {
		model.count
	}
}
