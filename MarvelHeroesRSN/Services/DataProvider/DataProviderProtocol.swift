//
//  DataProviderProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.02.2022.
//

import UIKit

protocol DataProviderProtocol: UICollectionViewDataSource,
							   UICollectionViewDelegate,
							   UICollectionViewDataSourcePrefetching {
	var owningViewController: MainScreenViewController? { get set }
	var heroesManager: HeroesManagerProtocol? { get set }
	
}
