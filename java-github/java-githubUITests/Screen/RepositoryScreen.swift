//
//  RepositoryScreen.swift
//  java-githubUITests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

@testable import java_github
import XCTest

class RepositoryScreen: BaseScreen {
	override init?(_ application: XCUIApplication, main: Element? = nil, timeout: Double = 1) {
		super.init(application, main: Element(rawValue: ScreenView.repository_id.rawValue))
	}
	
	
	enum ScreenView: String, ScreenElement {
		case repository_id
	}
}
