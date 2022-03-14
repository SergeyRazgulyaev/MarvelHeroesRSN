//
//  MockNetworkService.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

final class MockNetworkService: NetworkServiceProtocol {
	lazy var urlSession: URLSessionProtocol = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 20
		let session = URLSession(configuration: configuration)
		return session
	}()
	
	var isDataLoading: Bool = false
	var delegate: NetworkServiceDelegate?
	var urlParametersContainer: URLParametersContainer

	init(urlParametersContainer: URLParametersContainer) {
		self.urlParametersContainer = urlParametersContainer
	}

	func loadHeroesData(limit: Int,
						offset: Int,
						completion: @escaping ((Result<[HeroWithThumbnails], Error>) -> Void)) {
		isDataLoading = true
	}


}
