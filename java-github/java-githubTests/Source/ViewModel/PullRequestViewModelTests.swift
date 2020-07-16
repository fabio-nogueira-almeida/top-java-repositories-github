//
//  PullRequestViewModelTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class PullRequestViewModelTests: XCTestCase {
	
	// MARK: - Property
	
	var sut: PullRequestViewModel?
	let title = "title"
	let body = "body"
	let html = "html"
	let username = "username"
	let avatarurl = "avatarurl"
	
	// MARK: - Override

    override func setUpWithError() throws {
		let model = PullRequest(title: title,
								body: body,
								html: html,
								user: User(username: username,
										   avatarURL: avatarurl))
		sut = PullRequestViewModel()
		sut?.add(model: [model])
    }

}

// MARK: - Tests

extension PullRequestViewModelTests {
	func testShouldVerifyViewModelLabelsAPI() {
		XCTAssertEqual(sut?.getTitle(index: 0), title)
		XCTAssertEqual(sut?.getUserName(index: 0), username)
		XCTAssertEqual(sut?.getDescription(index: 0), body)
	}
	
	func testShouldVerifyListValueAPIs() {
		XCTAssertEqual(sut?.numberOfItemsInSection(), 1)
		XCTAssertEqual(sut?.numberOfItemsInSection(), 1)
	}
	
	func testShouldVerifyAppendModelAPI() {
		let newModel = PullRequest(title: "", body: "", html: "", user: User(username: "", avatarURL: ""))
		sut?.add(model: [newModel])
		
		XCTAssertEqual(sut?.numberOfItemsInSection(), 2)
	}
}
