//
//  DataProviderProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.02.2022.
//

import Foundation

protocol DataProviderProtocol {
	// MARK: - Methods for interactions with Heroes
	func fillHeroes(fromArray array: [Hero])
}
