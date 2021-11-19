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
    
    var sut: MainScreenDataProvider?
    var collectionView: UICollectionView?
    
    lazy var urlParametersContainer = URLParametersContainer(urlScheme: urlScheme,
                                                        baseURL: baseURL,
                                                        urlPath: urlPath,
                                                        ts: urlTS,
                                                        apiKey: urlApiKey,
                                                        hash: urlHash,
                                                        limit: limit,
                                                        offset: offset)
    var networkService: NetworkService?
    var mainScreenViewController: MainScreenViewController?
    
    override func setUpWithError() throws {
        networkService = NetworkService(urlParametersContainer: urlParametersContainer)
        mainScreenViewController = MainScreenViewController(networkService: networkService!)
        networkService?.delegate = mainScreenViewController
        sut = MainScreenDataProvider(owningViewController: mainScreenViewController!,
                                     cellIdentifier: "MainScreenCollectionViewCell")
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = itemsIndentation
            layout.minimumInteritemSpacing = itemsIndentation / 2
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .black
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
        collectionView?.dataSource = sut
    }

    override func tearDownWithError() throws {
        sut = nil
        collectionView = nil
        networkService = nil
        mainScreenViewController = nil
    }
    
    func testNumberOfSectionsIsOne() {
        XCTAssertEqual(collectionView?.numberOfSections, 1)
    }
    
    func testNumberOfItemsInSection() {
//        let app = XCUIApplication()
//        app.launch()
//        sut?.owningViewController?.loadHeroesDataFromNetWorkIfNeeded()
//        let mainScreenView = app.otherElements["mainScreenView"].firstMatch
//        XCTAssertTrue(mainScreenView.waitForExistence(timeout: 20))
//        XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 23)        
    }
}
