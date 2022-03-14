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

	let mockURLSession = MockURLSession()
	let limit: Int = 50
	let offset: Int = 0
	var urlParametersContainer: URLParametersContainer!

	override func setUpWithError() throws {
		urlParametersContainer = startURLParametersContainer
		sut = NetworkService(urlParametersContainer: urlParametersContainer)
		sut.urlSession = mockURLSession
	}

	override func tearDownWithError() throws {
		urlParametersContainer = nil
		sut = nil
	}

	func testIsDataLoading() {
		sut.loadHeroesData(limit: limit, offset: offset) { _ in }
		XCTAssertTrue(sut.isDataLoading)
	}

	func testLoadHeroesDataMethodUsesCorrectHost() {
		let completionHandler = { (result: (Result<[HeroWithThumbnails], Error>)) -> () in }
		sut.loadHeroesData(limit: limit, offset: offset, completion: completionHandler)

		guard let url = mockURLSession.url else {
			XCTFail()
			return
		}

		let urlComponents = URLComponents(url: url,
										  resolvingAgainstBaseURL: true)
		XCTAssertEqual(urlComponents?.host, "gateway.marvel.com")
	}
}
