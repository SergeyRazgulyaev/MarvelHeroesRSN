//
//  MainScreenDataProvider.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import UIKit

class MainScreenDataProvider: NSObject, DataProviderProtocol {
    //MARK: - Properties
    private let cellNumberFromEndForPrefetching: Int = 4
	private var heroes: [Hero] = []

    weak var owningViewController: MainScreenViewController?
	weak var heroesManager: HeroesManagerProtocol?

	// MARK: - Methods
	func fillHeroes(from heroesStorage: [Hero]) {
		heroes = heroesStorage
	}
}

//MARK: - UICollectionViewDataSource
extension MainScreenDataProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.cellIdentifier, for: indexPath) as? MainScreenCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellWithParametersFromNetwork(
			heroAvatarImage: heroes[indexPath.row].image,
			heroName: heroes[indexPath.row].name
		)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainScreenDataProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroScreenViewController = HeroScreenViewController(hero: heroes[indexPath.row])
        owningViewController?.navigationController?.pushViewController(heroScreenViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenDataProvider: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width:
						owningViewController?.mainScreenView.collectionViewItemWidth ?? 100,
					  height:
						owningViewController?.mainScreenView.collectionViewItemHeight ?? 100)
	}
}

//MARK: - UICollectionViewDataSourcePrefetching
extension MainScreenDataProvider: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell(for:)),
			  !(owningViewController?.networkService?.isDataLoading ?? false) else { return }
		owningViewController?.loadHeroesDataFromNetWork() { }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == (heroes.count - cellNumberFromEndForPrefetching)
    }
}
