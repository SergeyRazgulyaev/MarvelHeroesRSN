//
//  MainScreenDataProviderTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenDataProviderTests: XCTestCase {
	var sut: MainScreenDataProvider!
	
	var testHero: Hero!
	var heroesTestArray: [Hero]!

	var urlParametersContainer: URLParametersContainer!
	var networkService: NetworkServiceProtocol!
	var heroesManager: HeroesManagerProtocol!
	var mainScreenViewController: MainScreenViewController!


    
    override func setUpWithError() throws {
		urlParametersContainer = startURLParametersContainer
		testHero = MockHero.hero1
		heroesTestArray = [testHero]

        networkService = MockNetworkService()
		heroesManager = HeroesManager()
		sut = MainScreenDataProvider()
		mainScreenViewController = MockMainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: sut)
		networkService.delegate = mainScreenViewController
		sut.owningViewController = mainScreenViewController
    }

    override func tearDownWithError() throws {
		sut = nil
		testHero = nil
		heroesTestArray = nil
		urlParametersContainer = nil
        networkService = nil
		heroesManager = nil
        mainScreenViewController = nil
    }
    
//    func testNumberOfSectionsIsOne() {
//		let mockCollectionView = sut?.owningViewController?.mainScreenView.collectionView as? MockCollectionView
//		XCTAssertEqual(mockCollectionView?.numberOfSections, 1)
//    }
//
//	func testNumberOfItemsInSectionAtStartIsZero() {
//		let mockCollectionView = sut?.owningViewController?.mainScreenView.collectionView as? MockCollectionView
//		XCTAssertEqual(mockCollectionView?.numberOfItems(inSection: 0), 0)
//	}
//
//	func testCellForItemAtZeroIndexPathActivated() {
//		guard let sut = sut else { return }
//		sut.fillHeroes(fromArray: heroesTestArray)
//
//		let mockCollectionView = sut.owningViewController?.mainScreenView.collectionView as? MockCollectionView
//		mockCollectionView?.reloadData()
//
//		_ = mockCollectionView?.cellForItem(at: IndexPath(row: 0, section: 0))
//
//		XCTAssertEqual(mockCollectionView?.isCellForItemAtZeroIndexPathActivated, true)
//	}
//
//	func testCellForItemAtZeroIndexPathCallsConfigure() {
//		guard let sut = sut else { return }
//
//		sut.fillHeroes(fromArray: heroesTestArray)
//
//		//не понятно, как заменить collectionView у MainScreenViewController на mockCollectionView
//		let mockCollectionView = sut.owningViewController?.mainScreenView.collectionView as? MockCollectionView
//		mockCollectionView?.reloadData()
//
//		let cell = mockCollectionView?.cellForItem(at: IndexPath(item: 0, section: 0)) as? MockHeroCell
//		XCTAssertEqual(cell?.heroAvatarImageView.image, testHero.image)
//		XCTAssertEqual(cell?.heroNameLabel.text, testHero.name)
//	}
}
