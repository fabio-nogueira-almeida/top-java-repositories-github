//
//  BaseScreen.swift
//  java-githubUITests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest

class BaseScreen {
	var app: XCUIApplication
	var mainElement: Element
	
	var isActive: Bool {
		return mainElement.view.waitForExistence(timeout: 2)
	}
	
	init?(_ application: XCUIApplication, main: Element, timeout: Double = 1) {
		self.app = application
		
		self.mainElement = Element(rawValue: main.rawValue)

		if !main.view.waitForExistence(timeout: timeout) {
			XCTFail("Main screen not laod")
		}
	}
}

struct Element: ScreenElement, RawRepresentable, Equatable {
	init(rawValue: String) {
		self.rawValue = rawValue
	}
	
	var rawValue: String
	
	typealias RawValue = String
}

protocol ScreenElement {}

extension ScreenElement where Self: RawRepresentable, Self.RawValue == String {
	typealias RawValue = String
	
	private var app: XCUIApplication {
		return XCUIApplication()
	}
		
	var view: XCUIElement {
		return any.matching(identifier: self.rawValue).firstMatch
	}
	
	var any: XCUIElementQuery {
		return app.descendants(matching: .any)
	}
	
	var staticText: XCUIElement {
		return app.staticTexts[self.rawValue]
	}
	
	var exists: Bool {
		return view.exists
	}
	
	var navigation: XCUIElement {
		return app.navigationBars[self.rawValue]
	}
}
