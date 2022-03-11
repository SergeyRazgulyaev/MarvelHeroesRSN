//
//  MockMainScreenDataProvider.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 11.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

final class MockMainScreenDataProvider: MainScreenDataProvider {
	var testHeroesArray: [Hero] = []
	var isTestHeroesArrayFilled: Bool = false

	override func fillHeroes(from heroesStorage: [Hero]) {
		testHeroesArray = heroesStorage
		isTestHeroesArrayFilled = true
	}
}
