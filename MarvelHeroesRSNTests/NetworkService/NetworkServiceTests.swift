//
//  NetworkServiceTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import XCTest
@testable import MarvelHeroesRSN

class NetworkServiceTests: XCTestCase {
	var sut: NetworkServiceProtocol!

	let limit: Int = 50
	let offset: Int = 0
	var urlParametersContainer: URLParametersContainer!

    override func setUpWithError() throws {
		urlParametersContainer = startURLParametersContainer
		sut = NetworkService(urlParametersContainer: urlParametersContainer)

	}

    override func tearDownWithError() throws {
		urlParametersContainer = nil
		sut = nil
	}

	func testIsDataLoading() {
		sut.loadHeroesData(limit: limit, offset: offset) { _ in }
		XCTAssertTrue(sut.isDataLoading)
	}
}
