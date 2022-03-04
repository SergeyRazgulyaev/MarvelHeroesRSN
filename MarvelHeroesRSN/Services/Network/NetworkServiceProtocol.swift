//
//  NetworkServiceProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
	// MARK: - Properties
	var isDataLoading: Bool { get }

	// MARK: - Methods
    func loadHeroesData(limit: Int, offset: Int, completion: ((Result<[HeroWithThumbnails], Error>) -> Void)?)
}
