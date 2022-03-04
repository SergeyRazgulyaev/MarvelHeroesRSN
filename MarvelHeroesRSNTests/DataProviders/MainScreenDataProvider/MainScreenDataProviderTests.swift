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

	let testHeroe = Hero(id: 123,
						 name: "TestHeroName",
						 description: "TestHeroDescription",
						 image: UIImage(systemName: "tortoise.fill")!)
	lazy var testHeroes: [Hero] = [testHeroe]
    
    var collectionView: UICollectionView?
	var networkService: NetworkService?
	var mainScreenViewController: MainScreenViewController?
	var sut: MainScreenDataProvider?

    lazy var urlParametersContainer = URLParametersContainer(urlScheme: urlScheme,
                                                        baseURL: baseURL,
                                                        urlPath: urlPath,
                                                        ts: urlTS,
                                                        apiKey: urlApiKey,
                                                        hash: urlHash,
                                                        limit: limit,
                                                        offset: offset)

    
    override func setUpWithError() throws {
        networkService = NetworkService(urlParametersContainer: urlParametersContainer)
		sut = MainScreenDataProvider()
		guard let networkService = networkService, let sut = sut else {
			return
		}
		mainScreenViewController = MainScreenViewController(
			networkService: networkService,
			dataProvider: sut)

        networkService.delegate = mainScreenViewController
		sut.owningViewController = mainScreenViewController

		collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = itemsIndentation
            layout.minimumInteritemSpacing = itemsIndentation
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
    
	func testNumberOfItemsInSectionAtStartIsZero() {
		XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 0)
	}
}

extension MainScreenDataProviderTests {
	class MockCollectionView: UICollectionView {
		let itemsIndentation: CGFloat = 10.0
		var isCellForItemAtZeroIndexPathActivated = false

		override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .vertical
			layout.minimumLineSpacing = itemsIndentation
			layout.minimumInteritemSpacing = itemsIndentation
			super.init(frame: .zero, collectionViewLayout: layout)
			backgroundColor = .black
			translatesAutoresizingMaskIntoConstraints = false
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
			isCellForItemAtZeroIndexPathActivated = true
			return super.cellForItem(at: indexPath)
		}
	}
}
