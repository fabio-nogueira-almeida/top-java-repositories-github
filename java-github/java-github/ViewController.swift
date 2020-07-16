//
//  ViewController.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		if TestCoordinator.shared.isUITestingContext {
			TestCoordinator.shared.startFlow(from: self)
		} else {
			DispatchQueue.main.async {
				let controller = RepositoryCollectionViewController()
				let navigation = UINavigationController(rootViewController: controller)
				navigation.modalPresentationStyle = .fullScreen
				self.present(navigation, animated: true, completion: nil)
			}
		}
	}
}
