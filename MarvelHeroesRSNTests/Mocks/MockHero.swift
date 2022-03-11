//
//  MockHero.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import UIKit
@testable import MarvelHeroesRSN

final class MockHero {
	static let hero1 = Hero(id: 1,
							name: "TestHeroName1",
							description: "TestHeroDescription1",
							image: UIImage(systemName: "tortoise.fill")!
	)

	static let hero2 = Hero(id: 2,
							name: "TestHeroName2",
							description: "TestHeroDescription2",
							image: UIImage(systemName: "hare.fill")!
	)
}
