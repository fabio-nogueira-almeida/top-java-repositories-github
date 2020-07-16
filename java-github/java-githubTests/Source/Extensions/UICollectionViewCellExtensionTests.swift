//
//  UICollectionViewCellExtensionTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class UICollectionViewCellExtensionTests: XCTestCase {
	func testShouldVerifyIdentifier() {
		XCTAssertEqual(UICollectionViewCell.identifier(), "UICollectionViewCell")
		XCTAssertEqual(PullRequestCollectionViewCell.identifier(), "PullRequestCollectionViewCell")
	}
}
