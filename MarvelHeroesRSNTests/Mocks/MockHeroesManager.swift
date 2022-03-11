//
//  MockHeroesManager.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

final class MockHeroesManager: HeroesManagerProtocol {
	//MARK: - Properties
	var heroesStorage: [Hero] = []
	var isHeroesStorageFilled: Bool = false
	var isHeroesStorageCleared: Bool = false

	func getHero(byID id: Int) -> Hero? {
		return MockHero.hero1
	}
	
	func getHero(byName name: String) -> Hero? {
		return MockHero.hero2
	}

	func getAllHeroesFromStorage() -> [Hero] {
		return heroesStorage
	}

	func fillHeroesStorage(withDataFromNetwork heroesNetworkData: [HeroWithThumbnails],
						   isRefreshingData: Bool,
						   isCutOffUnsuccessfulHeroesCard: Bool) {
		heroesStorage.append(MockHero.hero1)
		heroesStorage.append(MockHero.hero2)
		isHeroesStorageFilled = true
	}

	func clearHeroesStorage() {
		heroesStorage = []
		isHeroesStorageCleared = true
	}
}
