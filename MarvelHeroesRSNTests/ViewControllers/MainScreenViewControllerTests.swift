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
        networkService = MockNetworkService()
		heroesManager = MockHeroesManager()
		dataProvider = MockMainScreenDataProvider()

		sut = MainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: dataProvider)

        networkService.delegate = sut
		dataProvider.owningViewController = sut
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
        XCTAssertTrue(sut?.mainScreenView.collectionView.delegate is MainScreenDataProvider)
    }
    
    func testWhenViewIsLoadedCollectionViewDataSourceIsSet() {
        sut?.loadViewIfNeeded()
        XCTAssertTrue(sut?.mainScreenView.collectionView.dataSource is MainScreenDataProvider)
    }
    
    func testWhenViewIsLoadedCollectionViewPrefetchDataSourceIsSet() {
        sut?.loadViewIfNeeded()
        XCTAssertTrue(sut?.mainScreenView.collectionView.prefetchDataSource is MainScreenDataProvider)
    }
    
    func testWhenViewIsLoadedCollectionViewDelegateEqualsCollectionViewDataSource() {
        XCTAssertEqual(
            sut?.mainScreenView.collectionView.delegate as? MainScreenDataProvider,
            sut?.mainScreenView.collectionView.dataSource as? MainScreenDataProvider)
    }
    
    func testWhenViewIsLoadedCollectionViewDelegateEqualsCollectionViewPrefetchDataSource() {
        XCTAssertEqual(
            sut?.mainScreenView.collectionView.delegate as? MainScreenDataProvider,
            sut?.mainScreenView.collectionView.prefetchDataSource as? MainScreenDataProvider)
    }
    
    func testWhenViewIsLoadedCollectionViewDataSourceEqualsCollectionViewPrefetchDataSource() {
        XCTAssertEqual(
            sut?.mainScreenView.collectionView.dataSource as? MainScreenDataProvider,
            sut?.mainScreenView.collectionView.prefetchDataSource as? MainScreenDataProvider)
    }
    
    func testLoadHeroesDataFromNetWorkMethodIsWorking() {
        sut?.loadHeroesDataFromNetWorkIfNeeded()
    }
}
