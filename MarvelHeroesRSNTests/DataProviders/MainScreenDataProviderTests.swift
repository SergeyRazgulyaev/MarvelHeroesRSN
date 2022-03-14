//
//  MainScreenDataProviderTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenDataProviderTests: XCTestCase {
	var sut: DataProviderProtocol!
	
	var testHero: Hero!
	var heroesTestArray: [Hero]!
	var urlParametersContainer: URLParametersContainer!
	var networkService: NetworkServiceProtocol!
	var heroesManager: HeroesManagerProtocol!
	var mainScreenViewController: MainScreenViewController!
	var collectionView: UICollectionView!
	var heroCell: MainScreenCollectionViewCell!

	override func setUpWithError() throws {
		sut = MainScreenDataProvider()
		
		urlParametersContainer = startURLParametersContainer
		testHero = MockHero.hero1
		heroesTestArray = [testHero]

		networkService = MockNetworkService(urlParametersContainer: urlParametersContainer)
		heroesManager = MockHeroesManager()
		mainScreenViewController = MainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: sut)
		mainScreenViewController.networkService = networkService
		mainScreenViewController.heroesManager = heroesManager
		mainScreenViewController.dataProvider = sut

		networkService.delegate = mainScreenViewController
		sut.owningViewController = mainScreenViewController
		sut.heroesManager = heroesManager
		collectionView = sut?.owningViewController?.mainScreenView.collectionView
		collectionView?.register(MainScreenCollectionViewCell.self,
								 forCellWithReuseIdentifier: MainScreenCollectionViewCell.cellIdentifier)
		collectionView.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
		heroCell = collectionView?.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.cellIdentifier, for: IndexPath(item: 0, section: 0)) as? MainScreenCollectionViewCell
	}

	override func tearDownWithError() throws {
		testHero = nil
		heroesTestArray = nil
		urlParametersContainer = nil
		networkService = nil
		heroesManager = nil
		mainScreenViewController = nil
		collectionView = nil
		heroCell = nil
		sut = nil
	}

	func testNumberOfSectionsIsOne() {
		XCTAssertEqual(collectionView?.numberOfSections, 1)
	}

	func testNumberOfItemsInSectionAtStartIsZero() {
		XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 0)
	}

	func testCellInFirstItemIsNotNil() {
		XCTAssertNotNil(heroCell)
	}

	func testCellInFirstItemHasLabel() {
		XCTAssertNotNil(heroCell.heroNameLabel)
	}

	func testCellInFirstItemHasImage() {
		XCTAssertNotNil(heroCell.heroAvatarImageView)
	}
}
