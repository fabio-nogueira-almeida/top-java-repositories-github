//
//  RepositoryCollectionViewCell.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
	
	// MARK: - IBOutlet

	@IBOutlet private var nameLabel: UILabel?
	@IBOutlet private var descriptionLabel: UILabel?
	@IBOutlet private var usernameLabel: UILabel?
	@IBOutlet private var forkLabel: UILabel?
	@IBOutlet private var starLabel: UILabel?
	@IBOutlet private var startImageView: UIImageView?
	@IBOutlet private var forkImageView: UIImageView?
	@IBOutlet private var userImageView: UIImageView?
	
	// MARK: - Public
	
	func bind(viewModel: RepositoryViewModel, index: Int) {
		nameLabel?.text = viewModel.getname(index: index)
		descriptionLabel?.text = viewModel.getDescription(index: index)
		usernameLabel?.text = viewModel.getUsername(index: index)
		forkLabel?.text = viewModel.getFork(index: index)
		starLabel?.text = viewModel.getStars(index: index)
		userImageView?.image = viewModel.getUserImage(index: index)
	}
	
	// MARK: - Override
	
	override func layoutSubviews() {
		setupAccessibility()
		setupLayout()
	}
	
	// MARK: - Private
	
	private func setupAccessibility() {
		nameLabel?.isAccessibilityElement = true
		descriptionLabel?.isAccessibilityElement = true
		usernameLabel?.isAccessibilityElement = true
		forkLabel?.isAccessibilityElement = true
		starLabel?.isAccessibilityElement = true
		startImageView?.isAccessibilityElement = false
		forkImageView?.isAccessibilityElement = false
		userImageView?.isAccessibilityElement = false
	}
	
	private func setupLayout() {
		if let width = userImageView?.frame.width {
			userImageView?.layer.cornerRadius = width / 2
			userImageView?.layer.masksToBounds = true
		}
	}
}
