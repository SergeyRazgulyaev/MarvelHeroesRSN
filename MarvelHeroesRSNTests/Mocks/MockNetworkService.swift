//
//  MockNetworkService.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

final class MockNetworkService: NetworkServiceProtocol {
	var isDataLoading: Bool = false
	var delegate: NetworkServiceDelegate?

	func loadHeroesData(limit: Int,
						offset: Int,
						completion: @escaping ((Result<[HeroWithThumbnails], Error>) -> Void)) {
		isDataLoading = true
	}
}
