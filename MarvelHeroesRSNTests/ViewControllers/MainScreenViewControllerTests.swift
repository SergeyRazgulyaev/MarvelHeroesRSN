//
//  MainScreenViewControllerTests.swift
//  MainScreenViewControllerTests
//
//  Created by Sergey Razgulyaev on 12.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenViewControllerTests: XCTestCase {
    let urlScheme = "https"
    let baseURL = "gateway.marvel.com"
    let urlPath = "/v1/public/characters"
    let urlTS = 1
    let urlApiKey = "2acb17a14fab947ec914f6731a6f3585"
    let urlHash = "7a082702e822cdb6e752c8ca132ccd92"
    let limit = 50
    let offset = 0
    
    lazy var urlParametersContainer = URLParametersContainer(urlScheme: urlScheme,
                                                        baseURL: baseURL,
                                                        urlPath: urlPath,
                                                        ts: urlTS,
                                                        apiKey: urlApiKey,
                                                        hash: urlHash,
                                                        limit: limit,
                                                        offset: offset)
    lazy var networkService: NetworkService? = NetworkService(urlParametersContainer: urlParametersContainer)
    lazy var sut: MainScreenViewController? = MainScreenViewController(networkService: networkService!)
    
    override func setUpWithError() throws {
        networkService?.delegate = sut
    }

    override func tearDownWithError() throws {
        networkService = nil
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
    
//    func testWhenRefreshingDataLoadHeroesDataFromNetWorkMethodIsWorking() {
//        sut?.loadViewIfNeeded()
//        sut?.refreshControl.
//    }
}
