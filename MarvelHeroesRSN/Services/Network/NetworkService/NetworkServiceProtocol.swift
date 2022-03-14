//
//  NetworkServiceProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
	// MARK: - Properties
	var urlSession: URLSessionProtocol { get set }
	var isDataLoading: Bool { get }
	var delegate: NetworkServiceDelegate? { get set }

	// MARK: - Init
	init(urlParametersContainer: URLParametersContainer)

	// MARK: - Methods
	func loadHeroesData(limit: Int,
						offset: Int,
						completion: @escaping ((Result<[HeroWithThumbnails], Error>) -> Void))
}
