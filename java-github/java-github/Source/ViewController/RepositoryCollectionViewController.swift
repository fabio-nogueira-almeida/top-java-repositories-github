//
//  RepositoryCollectionViewController.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation
import UIKit

class RepositoryCollectionViewController: UIViewController {
	
	// MARK: - Property
	
	private var collectionView: UICollectionView?
	private var viewModel = RepositoryViewModel()
	private let business = RepositoryBusiness()
	
	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Github"
		setupLayout()
		registerCell()
		viewModel.delegate = self
		business.delegate = self
		business.fetchData()
    }
	
	// MARK: - Private
	
	private func registerCell() {
		if let collectionView = collectionView {
			RepositoryCollectionViewCell.register(for: collectionView)
		}
	}
	
	private func setupLayout() {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.estimatedItemSize = .zero
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.itemSize = CGSize(width: self.view.frame.width, height: 130)

		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
		collectionView?.contentInsetAdjustmentBehavior = .always
		collectionView?.backgroundColor = .white
		collectionView?.delegate = self
		collectionView?.dataSource = self

		self.view.addSubview(collectionView!)
	}
	
	private func addMore(repositories: [Repository]) {
		viewModel.add(model: repositories)
		DispatchQueue.main.async {
			self.collectionView?.reloadData()
		}
	}
}

// MARK: UICollectionViewDataSource

extension RepositoryCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.numberOfSections()
    }


    func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView,
								 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = RepositoryCollectionViewCell.identifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
													  for: indexPath) as! RepositoryCollectionViewCell
		cell.bind(viewModel: viewModel, index: indexPath.row)
    
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension RepositoryCollectionViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.didSelectItemAt(indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						willDisplay cell: UICollectionViewCell,
						forItemAt indexPath: IndexPath) {
		if viewModel.isLastItem(row: indexPath.row) {
			business.fetchData()
		}
	}
}

extension RepositoryCollectionViewController: RepositoryBusinessDelegate {
	func dataFetched(items: [Repository]?) {
		if let items = items {
			addMore(repositories: items)
		}
	}
}

extension RepositoryCollectionViewController :RepositoryViewModelDelegate {
	func presentPullRequests(for repository: Repository) {
		let controller = PullRequestCollectionViewController()
		controller.setup(model: repository)
		navigationController?.pushViewController(controller, animated: true)
	}
}
