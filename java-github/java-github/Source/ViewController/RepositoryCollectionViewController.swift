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
	
	var collectionView: UICollectionView?
	var viewModel = RepositoryViewModel()
	let business = RepositoryBusiness()
	
	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.estimatedItemSize = .zero
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
		layout.itemSize = CGSize(width: self.view.frame.width, height: 130)
        

		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
		collectionView?.contentInsetAdjustmentBehavior = .always
		collectionView?.delegate = self
		collectionView?.dataSource = self
		collectionView?.backgroundColor = UIColor.white

		self.view.addSubview(collectionView!)
		
		registerCell()
		business.delegate = self
		business.fetchData()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView?.reloadData()
	}
	
	// MARK: - Private
	
	private func registerCell() {
		if let collectionView = collectionView {
			RepositoryCollectionViewCell.register(for: collectionView)
		}
	}

}

// MARK: UICollectionViewDataSource

extension RepositoryCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
		return viewModel.numberOfSections()
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
	
//	optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	
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
			viewModel.add(model: items)
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
		}
	}
}
