//
//  HeroesManagerProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import Foundation

protocol HeroesManagerProtocol: AnyObject {
	//MARK: - Getting Methods
	func getHero(byID id: Int) -> Hero?
	func getHero(byName name: String) -> Hero?
	func getAllHeroesFromStorage() -> [Hero]

	//MARK: - Filling Methods
	func fillHeroesStorage(withDataFromNetwork heroesNetworkData: [HeroWithThumbnails],
						   isRefreshingData: Bool,
						   isCutOffUnsuccessfulHeroesCard: Bool)

	//MARK: - Clearing Methods
	func clearHeroesStorage()
}
