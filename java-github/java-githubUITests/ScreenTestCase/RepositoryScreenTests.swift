//
//  RepositoryScreenTests.swift
//  java-githubUITests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//


import XCTest
import UIKit
@testable import java_github

class RepositoryScreenTests: BaseTestCase {
	
	override func contextData() -> [String: String] {
		return [ApplicationEnviroment.controller.rawValue: String(describing: RepositoryCollectionViewController.self)]
	}
}

extension RepositoryScreenTests {
	func testShouldOpenScreen() {
		_ = RepositoryScreen(app)
	}
	
	func testShouldVerifyTitle() {
		XCTAssertTrue(app.staticTexts["Github"].exists)
	}
}
