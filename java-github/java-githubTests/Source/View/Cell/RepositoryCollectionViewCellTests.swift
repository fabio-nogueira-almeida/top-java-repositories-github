//
//  RepositoryCollectionViewCellTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

class RepositoryCollectionViewCellMock: RepositoryCollectionViewCell {
	var bindWasCalled = false
	
	override func bind(viewModel: RepositoryViewModel, index: Int) {
		super.bind(viewModel: viewModel, index: index)
		bindWasCalled = true
	}
}

class RepositoryCollectionViewCellTests: XCTestCase {
	
	var sut: RepositoryCollectionViewCellMock?
	
	// MARK: - Private
	
	private func createData() -> RepositoryViewModel {
		let model = Repository(id: 0, name: "", description: "", forks: 0, stargazers: 0, owner: Owner(login: "", avatarURL: ""))
		let viewModel = RepositoryViewModel()
		viewModel.add(model: [model])
		return viewModel
	}
	
	// MARK: - Override

	override func setUpWithError() throws {
		sut = RepositoryCollectionViewCellMock()
	}
}

// MARK: - Tests

extension RepositoryCollectionViewCellTests {

	func testShouldVerifyIfBindWillBeCalled() throws {
		let viewModel = createData()
		
		sut?.bind(viewModel: viewModel, index: 0)
		
		XCTAssertTrue(sut?.bindWasCalled == true)
	}
}
