//
//  RepositoryBusinessTests.swift
//  java-githubTests
//
//  Created by Fábio Nogueira de Almeida on 15/07/20.
//

import XCTest
@testable import java_github

// MARK: - Mock

class RepositoryBusinessMock: RepositoryBusiness {
	var fetchDataWasCalled = false
	
	override func fetchData() {
		super.fetchData()
		fetchDataWasCalled = true
	}
}

class RepositoryBusinessTests: XCTestCase {
	
	// MARK: - Property
	
	var sut: RepositoryBusinessMock?

	// MARK: - Override
	
    override func setUpWithError() throws {
        sut = RepositoryBusinessMock()
    }

}

// MARK: - Tests

extension RepositoryBusinessTests {
	func testShouldCallFetchData() {
		sut?.fetchData()
		
		XCTAssertTrue(sut?.fetchDataWasCalled == true)
	}
}
