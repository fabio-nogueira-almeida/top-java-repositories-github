//
//  PullRequestBusinessTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class PullRequestBusinessMock: PullRequestBusiness {
	var fetchDataWasCalled = false

	override func fetchData() {
		super.fetchData()
		fetchDataWasCalled = true
	}
}

class PullRequestBusinessTests: XCTestCase {
	
	// MARK: - Property
	
	var sut: PullRequestBusinessMock?

	// MARK: - Override
	
    override func setUpWithError() throws {
		let model = Repository(id: 0, name: "name", description: "description", forks: 0, stargazers: 0, owner: Owner(login: "login", avatarURL: "url"))
		sut = PullRequestBusinessMock(repository: model)
    }

}

// MARK: - Tests

extension PullRequestBusinessTests {
	
	func testShouldVerifyInitialize() {
		XCTAssertNotNil(sut?.repository.description)
		XCTAssertNotNil(sut?.repository.forks)
		XCTAssertNotNil(sut?.repository.id)
		XCTAssertNotNil(sut?.repository.name)
		XCTAssertNotNil(sut?.repository.stargazers)
		XCTAssertNotNil(sut?.repository.owner)
	}
	
	func testShouldVerifyIfFetchDataWillBeCalled() {
		sut?.fetchData()
		
		XCTAssertTrue(sut?.fetchDataWasCalled == true)
	}
}
