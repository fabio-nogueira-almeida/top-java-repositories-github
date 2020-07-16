//
//  UITestEnviroment.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import Foundation
import UIKit

#if DEBUG

enum ApplicationArguments: String {
	case uiTesting = "UITesting"
}

enum ApplicationEnviroment: String {
	case view = "view"
	case controller = "controller"
}

struct TestCoordinator {
	
	// MARK: - Properties
	
	static var shared = TestCoordinator()
	
	var presenter: UIViewController?
	
	let window = UIWindow(frame: UIScreen.main.bounds)
	
	var isUITestingContext: Bool {
		ProcessInfo.processInfo.arguments.contains(ApplicationArguments.uiTesting.rawValue)
	}
	
	// MARK: - Private
	
	private func presentController(name: String, from bundle: Bundle) {
		let controllerClass = NSClassFromString("java_github." + name)! as! UIViewController.Type
		let controller = controllerClass.init()
		_ = controller.view
		let navigationController = UINavigationController(rootViewController: controller)
		navigationController.modalPresentationStyle = .fullScreen
		presenter?.present(navigationController, animated: true, completion: nil)
	}
	
	private func runTestingWindow() {
		let bundle = Bundle.main
		
		if let controleName = ProcessInfo.processInfo.environment[ApplicationEnviroment.controller.rawValue] {
			DispatchQueue.main.async {
				presentController(name: controleName, from: bundle)
			}
		}
	}
	
	// MARK: - Public
	
	mutating func startFlow(from presenter: UIViewController) {
		self.presenter = presenter
		runTestingWindow()
	}
}

#endif
