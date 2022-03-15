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

	func testLoadHeroesDataMethodUsesCorrectURLComponents() {
		let completionHandler = { (_: (Result<[HeroWithThumbnails], Error>)) -> () in }
		sut.loadHeroesData(limit: limit, offset: offset, completion: completionHandler)
		
		guard let url = mockURLSession.url else {
			return
		}
		let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

		guard let queryItems = urlComponents?.queryItems else {
			return
		}
		let queryItemTS = URLQueryItem(name: "ts", value: "1")
		let queryItemAPIKey = URLQueryItem(name: "apikey", value: "2acb17a14fab947ec914f6731a6f3585")
		let queryItemHash = URLQueryItem(name: "hash", value: "7a082702e822cdb6e752c8ca132ccd92")

		XCTAssertEqual(urlComponents?.scheme, "https")
		XCTAssertEqual(urlComponents?.host, "gateway.marvel.com")
		XCTAssertEqual(urlComponents?.path, "/v1/public/characters")
		XCTAssertTrue(queryItems.contains(queryItemTS))
		XCTAssertTrue(queryItems.contains(queryItemAPIKey))
		XCTAssertTrue(queryItems.contains(queryItemHash))
	}
}
