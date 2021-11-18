//
//  MainScreenDataProvider.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import UIKit

class MainScreenDataProvider: NSObject {
    //MARK: - Properties
    private let cellIdentifier: String
    private let cellNumberFromEnd: Int = 4
    
    //MARK: - Init
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
}

//MARK: - UICollectionViewDataSource
extension MainScreenDataProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainScreenCollectionViewCell else { return UICollectionViewCell() }
//        cell.configureCellWithParametersFromNetwork(heroAvatarImage: heroes[indexPath.row].image, heroName: heroes[indexPath.row].name)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainScreenDataProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let heroScreenViewController = HeroScreenViewController(hero: heroes[indexPath.row])
//        navigationController?.pushViewController(heroScreenViewController, animated: true)
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension MainScreenDataProvider: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard indexPaths.contains(where: isLoadingCell(for:)),
//              !isDataLoading else { return }
//        loadHeroesDataFromNetWork()
    }
    
//    func isLoadingCell(for indexPath: IndexPath) -> Bool {
//        return indexPath.row == (heroes.count - cellNumberFromEnd)
//    }
}
