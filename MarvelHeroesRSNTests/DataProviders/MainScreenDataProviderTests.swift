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


    
    override func setUpWithError() throws {
		sut = MainScreenDataProvider()
		
		urlParametersContainer = startURLParametersContainer
		testHero = MockHero.hero1
		heroesTestArray = [testHero]

        networkService = MockNetworkService()
		heroesManager = MockHeroesManager()
		mainScreenViewController = MainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: sut)
		networkService.delegate = mainScreenViewController
		sut.owningViewController = mainScreenViewController
    }

    override func tearDownWithError() throws {
		testHero = nil
		heroesTestArray = nil
		urlParametersContainer = nil
        networkService = nil
		heroesManager = nil
        mainScreenViewController = nil
		sut = nil
    }
    
    func testNumberOfSectionsIsOne() {
		let collectionView = sut?.owningViewController?.mainScreenView.collectionView
		XCTAssertEqual(collectionView?.numberOfSections, 1)
    }

	func testNumberOfItemsInSectionAtStartIsZero() {
		let collectionView = sut?.owningViewController?.mainScreenView.collectionView
		XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 0)
	}
}
