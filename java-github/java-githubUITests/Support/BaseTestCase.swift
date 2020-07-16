//
//  BaseTestCase.swift
//  java-githubUITests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest

class BaseTestCase: XCTestCase {
	var app: XCUIApplication!
	
	override open func setUp() {
		super.setUp()
		continueAfterFailure = true
		self.app = XCUIApplication()
		app.launchEnvironment = contextData()
		app.launchArguments += [ApplicationArguments.uiTesting.rawValue]
		
		if shouldLaunchInSetup {
			app.launch()
		}
	}
	
	open func contextData() -> [String: String] {
		return ["": ""]
	}
	
	open var shouldLaunchInSetup: Bool {
		return true
	}
	
	override open func tearDown() {
		app.terminate()
		app.launchEnvironment = [:]
		app = nil
		
		super.tearDown()
	}
}
