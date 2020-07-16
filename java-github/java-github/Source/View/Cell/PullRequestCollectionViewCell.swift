//
//  PullRequestCollectionViewCell.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import UIKit

class PullRequestCollectionViewCell: UICollectionViewCell {

	// MARK: - IBOutlet
	
	@IBOutlet var repositoryLabel: UILabel?
	@IBOutlet var bodyTitleLabel: UILabel?
	@IBOutlet var usernameLabel: UILabel?
	@IBOutlet var userImageView: UIImageView?
	
	// MARK: - Public
	
	func bind(viewModel: PullRequestViewModel, index: Int) {
		repositoryLabel?.text = viewModel.getTitle(index: index)
		bodyTitleLabel?.text = viewModel.getDescription(index: index)
		usernameLabel?.text = viewModel.getUserName(index: index)
		userImageView?.image = viewModel.getUserImage(index: index)
	}
	
	// MARK: - Override
	
	override func layoutSubviews() {
		setupAccessibility()
	}
	
	// MARK: - Private
	
	private func setupAccessibility() {
		repositoryLabel?.isAccessibilityElement = true
		bodyTitleLabel?.isAccessibilityElement = true
		usernameLabel?.isAccessibilityElement = true
		userImageView?.isAccessibilityElement = false
	}

}
