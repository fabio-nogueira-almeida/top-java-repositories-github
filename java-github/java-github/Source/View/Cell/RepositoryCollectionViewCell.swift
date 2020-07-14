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
	@IBOutlet private var userImageView: UIImageView?
	
	// MARK: - Public
	
	func bind(viewModel: RepositoryViewModel, index: Int) {
		nameLabel?.text = viewModel.getname(index: index)
		descriptionLabel?.text = viewModel.getDescription(index: index)
		usernameLabel?.text = viewModel.getUsername(index: index)
		forkLabel?.text = viewModel.getFork(index: index)
		starLabel?.text = viewModel.getStars(index: index)
	}
}
