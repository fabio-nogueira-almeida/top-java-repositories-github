//
//  PullRequestCollectionViewController.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import UIKit

class PullRequestCollectionViewController: UIViewController {
	
	// MARK: - Property
	
	private var collectionView: UICollectionView?
	private var viewModel = PullRequestViewModel()
	private var business: PullRequestBusiness?
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
		registerCell()
		business?.delegate = self
		business?.fetchData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//		title = "Github
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView?.reloadData()
	}
	
	// MARK: - Public
	
	func setup(model: Repository) {
		title = model.name
		business = PullRequestBusiness(repository: model)
	}
	
	// MARK: - Private
	
	private func addMore(pullRequests: [PullRequest]) {
		viewModel.add(model: pullRequests)
		DispatchQueue.main.async {
			self.collectionView?.reloadData()
		}
	}
	
	private func registerCell() {
		if let collectionView = collectionView {
			PullRequestCollectionViewCell.register(for: collectionView)
		}
	}
	
	private func setupLayout() {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.estimatedItemSize = .zero
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.itemSize = CGSize(width: self.view.frame.width, height: 90)

		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
		collectionView?.contentInsetAdjustmentBehavior = .always
		collectionView?.backgroundColor = .white
		collectionView?.dataSource = self

		self.view.addSubview(collectionView!)
	}
}

// MARK: UICollectionViewDataSource

extension PullRequestCollectionViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.numberOfSections()
	}


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItemsInSection()
	}

	func collectionView(_ collectionView: UICollectionView,
								 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = PullRequestCollectionViewCell.identifier()
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
													  for: indexPath) as! PullRequestCollectionViewCell
		cell.bind(viewModel: viewModel, index: indexPath.row)

		return cell
	}
}

extension PullRequestCollectionViewController: PullRequestBusinessDelegate {
	func dataFetched(items: [PullRequest]?) {
		if let items = items {
			addMore(pullRequests: items)
		}
	}
}
