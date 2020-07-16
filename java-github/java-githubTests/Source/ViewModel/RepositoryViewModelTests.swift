//
//  RepositoryViewModelTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class RepositoryViewModelTests: XCTestCase {
	
	// MARK: - Property
	
	var sut: RepositoryViewModel?
	let nameText = "name"
	let descriptionText = "description"
	let login = "login"
	let stars = 1
	let forks = 2
	
	// MARK: - Override

	override func setUpWithError() throws {
		let model = Repository(id: 0,
							   name: nameText,
							   description: descriptionText,
							   forks: forks,
							   stargazers: stars,
							   owner: Owner(login: login, avatarURL: ""))
		sut = RepositoryViewModel()
		sut?.add(model: [model])
	}

}

//MARK: - Tests

extension RepositoryViewModelTests {
	func testShouldVerifyViewModelLabelsAPI() {
		XCTAssertEqual(sut?.getname(index: 0), nameText)
		XCTAssertEqual(sut?.getDescription(index: 0), descriptionText)
		XCTAssertEqual(sut?.getFork(index: 0), String(forks))
		XCTAssertEqual(sut?.getStars(index: 0), String(stars))
		XCTAssertEqual(sut?.getUsername(index: 0), login)
	}

	func testShouldVerifyListValueAPIs() {
		XCTAssertEqual(sut?.numberOfItemsInSection(), 1)
		XCTAssertEqual(sut?.numberOfItemsInSection(), 1)
	}

	func testShouldVerifyAppendModelAPI() {
		let newModel = Repository(id: 0, name: "", description: "", forks: 0, stargazers: 0, owner: Owner(login: "", avatarURL: ""))
		sut?.add(model: [newModel])

		XCTAssertEqual(sut?.numberOfItemsInSection(), 2)
	}
	
	func testShouldVerifyIfIsLastItem() {
		XCTAssertTrue(sut?.isLastItem(row: 0) == true)
	}
	
	func testShouldVerifyIfIsNotLastItem() {
		XCTAssertTrue(sut?.isLastItem(row: 1) == false)
	}

}
