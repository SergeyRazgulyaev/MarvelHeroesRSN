//
//  MainScreenViewControllerTests.swift
//  MainScreenViewControllerTests
//
//  Created by Sergey Razgulyaev on 12.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenViewControllerTests: XCTestCase {
	var sut: MainScreenViewController!

	var urlParametersContainer: URLParametersContainer!
	var networkService: NetworkServiceProtocol!
	var heroesManager: HeroesManagerProtocol!
	var dataProvider: DataProviderProtocol!

	override func setUpWithError() throws {
		urlParametersContainer = startURLParametersContainer
		networkService = MockNetworkService(urlParametersContainer: urlParametersContainer)
		heroesManager = MockHeroesManager()
		dataProvider = MockMainScreenDataProvider()

		sut = MainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: dataProvider)
		sut.networkService = networkService
		sut.heroesManager = heroesManager
		sut.dataProvider = dataProvider

		networkService.delegate = sut
		dataProvider.owningViewController = sut
		dataProvider.heroesManager = heroesManager
	}

	override func tearDownWithError() throws {
		urlParametersContainer = nil
		networkService = nil
		heroesManager = nil
		dataProvider = nil
		sut = nil
	}

	func testIsViewLoaded() {
		sut?.loadViewIfNeeded()

		XCTAssertEqual(sut?.isViewLoaded, true)
	}

	func testWhenViewIsLoadedCollectionViewIsNotNil() {
		XCTAssertNotNil(sut?.mainScreenView.collectionView)
	}

	func testWhenViewIsLoadedDataProviderIsNotNil() {
		XCTAssertNotNil(sut?.dataProvider)
	}

	func testWhenViewIsLoadedCollectionViewDelegateIsSet() {
		sut?.loadViewIfNeeded()

		XCTAssertTrue(sut?.mainScreenView.collectionView.delegate is MockMainScreenDataProvider)
	}

	func testWhenViewIsLoadedCollectionViewDataSourceIsSet() {
		sut?.loadViewIfNeeded()

		XCTAssertTrue(sut?.mainScreenView.collectionView.dataSource is MockMainScreenDataProvider)
	}

	func testWhenViewIsLoadedCollectionViewPrefetchDataSourceIsSet() {
		sut?.loadViewIfNeeded()

		XCTAssertTrue(sut?.mainScreenView.collectionView.prefetchDataSource is MockMainScreenDataProvider)
	}

	func testWhenViewIsLoadedCollectionViewDelegateEqualsCollectionViewDataSource() {
		XCTAssertEqual(
			sut?.mainScreenView.collectionView.delegate as? MockMainScreenDataProvider,
			sut?.mainScreenView.collectionView.dataSource as? MockMainScreenDataProvider)
	}

	func testWhenViewIsLoadedCollectionViewDelegateEqualsCollectionViewPrefetchDataSource() {
		XCTAssertEqual(
			sut?.mainScreenView.collectionView.delegate as? MockMainScreenDataProvider,
			sut?.mainScreenView.collectionView.prefetchDataSource as? MockMainScreenDataProvider)
	}

	func testWhenViewIsLoadedCollectionViewDataSourceEqualsCollectionViewPrefetchDataSource() {
		XCTAssertEqual(
			sut?.mainScreenView.collectionView.dataSource as? MockMainScreenDataProvider,
			sut?.mainScreenView.collectionView.prefetchDataSource as? MockMainScreenDataProvider)
	}
}
