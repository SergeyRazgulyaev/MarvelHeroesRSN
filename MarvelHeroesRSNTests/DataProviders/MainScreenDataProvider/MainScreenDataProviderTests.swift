//
//  MainScreenDataProviderTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenDataProviderTests: XCTestCase {
    let urlScheme = "https"
    let baseURL = "gateway.marvel.com"
    let urlPath = "/v1/public/characters"
    let urlTS = 1
    let urlApiKey = "2acb17a14fab947ec914f6731a6f3585"
    let urlHash = "7a082702e822cdb6e752c8ca132ccd92"
    let limit = 50
    let offset = 0
    
    let itemsIndentation: CGFloat = 10.0

	let testHero = Hero(id: 123,
						 name: "TestHeroName",
						 description: "TestHeroDescription",
						 image: UIImage(systemName: "tortoise.fill")!)
	lazy var testHeroes: [Hero] = [testHero]

	var networkService: NetworkServiceProtocol!
	var heroesManager: HeroesManagerProtocol!
	var mainScreenViewController: MainScreenViewController!
	var sut: MainScreenDataProvider!

    lazy var urlParametersContainer = URLParametersContainer(urlScheme: urlScheme,
                                                        baseURL: baseURL,
                                                        urlPath: urlPath,
                                                        ts: urlTS,
                                                        apiKey: urlApiKey,
                                                        hash: urlHash,
                                                        limit: limit,
                                                        offset: offset)

    
    override func setUpWithError() throws {
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
        networkService = nil
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
//		sut.fillHeroes(fromArray: testHeroes)
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
//		sut.fillHeroes(fromArray: testHeroes)
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
