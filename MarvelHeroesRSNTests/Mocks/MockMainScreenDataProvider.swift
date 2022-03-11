//
//  MockMainScreenDataProvider.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 11.03.2022.
//

import UIKit
@testable import MarvelHeroesRSN

final class MockMainScreenDataProvider: NSObject, DataProviderProtocol {
	//MARK: - Properties
	let cellNumberFromEndForPrefetching: Int = 4
	var heroes: [Hero] = [MockHero.hero1]
	var isTestHeroesArrayFilled: Bool = false

	weak var owningViewController: MainScreenViewController?
	weak var heroesManager: HeroesManagerProtocol?

	func fillHeroes(from heroesStorage: [Hero]) {
		heroes = heroesStorage
		isTestHeroesArrayFilled = true
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: MainScreenCollectionViewCell.cellIdentifier,
			for: indexPath) as? MainScreenCollectionViewCell else {
				return UICollectionViewCell()
			}

		cell.configureCellWithParametersFromNetwork(
			heroAvatarImage: heroes[0].image,
			heroName: heroes[0].name)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) { }
}
