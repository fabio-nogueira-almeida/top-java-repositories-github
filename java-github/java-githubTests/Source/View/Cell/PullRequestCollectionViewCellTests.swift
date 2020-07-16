//
//  PullRequestCollectionViewCellTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class PullRequestCollectionViewCellMock: PullRequestCollectionViewCell {
	var bindWasCalled = false
	
	override func bind(viewModel: PullRequestViewModel, index: Int) {
		super.bind(viewModel: viewModel, index: index)
		bindWasCalled = true
	}
}

class PullRequestCollectionViewCellTests: XCTestCase {
	
	var sut: PullRequestCollectionViewCellMock?
	
	// MARK: - Private
	
	private func createData() -> PullRequestViewModel {
		let model = PullRequest(title: "title", body: "body", html: "html", user: User(username: "name", avatarURL: ""))
		let model2 = PullRequest(title: "title2", body: "body2", html: "html2", user: User(username: "name", avatarURL: ""))
		let viewModel = PullRequestViewModel()
		viewModel.add(model: [model, model2])
		return viewModel
	}
	
	// MARK: - Override

    override func setUpWithError() throws {
        sut = PullRequestCollectionViewCellMock()
	}
}

// MARK: - Tests

extension PullRequestCollectionViewCellTests {

	func testShouldVerifyIfBindWillBeCalled() throws {
		let viewModel = createData()
		
		sut?.bind(viewModel: viewModel, index: 0)
		
		XCTAssertTrue(sut?.bindWasCalled == true)
	}
}
