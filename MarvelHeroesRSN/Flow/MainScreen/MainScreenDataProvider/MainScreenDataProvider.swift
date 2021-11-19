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
    private let edgeIndentation: CGFloat = 10.0
    private let indentationBetweenCells: CGFloat = 7.0
    private let numberOfCellsInCollectionViewRow: Int = 3
    private let cellNumberFromEnd: Int = 4
    private var imageInCellWidthAndHeight: CGFloat {
//        100
        guard let owningViewController = owningViewController else { return 100 }
        return ((owningViewController.mainScreenView.bounds.width - (2 * edgeIndentation)) / CGFloat(numberOfCellsInCollectionViewRow) - indentationBetweenCells)
    }
    private lazy var collectionViewItemWidth: CGFloat = {
        imageInCellWidthAndHeight
    }()
    private lazy var collectionViewItemHeight: CGFloat = {
        guard let owningViewController = owningViewController else { return 100 }
        return imageInCellWidthAndHeight + (owningViewController.mainScreenView.getHeroNameLabelHeight())
    }()
    private(set) var heroes: [Hero] = []
    private(set) var heroesManager = HeroesManager()
    private(set) weak var owningViewController: MainScreenViewController?

    //MARK: - Init
    init(owningViewController: MainScreenViewController,
         cellIdentifier: String) {
        self.owningViewController = owningViewController
        self.cellIdentifier = cellIdentifier
    }
    
    //MARK: - Methods
    func fillHeroes(fromArray array: [Hero]) {
        heroes = array
    }
}

//MARK: - UICollectionViewDataSource
extension MainScreenDataProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainScreenCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellWithParametersFromNetwork(heroAvatarImage: heroes[indexPath.row].image, heroName: heroes[indexPath.row].name)
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
        return CGSize(width: collectionViewItemWidth,
                      height: collectionViewItemHeight)
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension MainScreenDataProvider: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell(for:)),
              !(owningViewController?.isDataLoading ?? false) else { return }
        owningViewController?.loadHeroesDataFromNetWork()
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == (heroes.count - cellNumberFromEnd)
    }
}
