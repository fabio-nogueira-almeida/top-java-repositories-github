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
		
		
		let provider = GithubProvider()
		provider.getJavaRepositories(page: 1) { repositories, page in
			print("-----")
			print("Repositories: \(String(describing: repositories))/")
			
			if let repository = repositories?.first {
				provider.getPullRequest(repository: repository.name,
										owner: repository.owner.login) { pullrequests, page in
											print("\\\\\\\\\\\\\\")
				}
			}

			
		}
		
	}


}

