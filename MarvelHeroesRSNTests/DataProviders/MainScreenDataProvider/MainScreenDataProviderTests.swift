//
//  MainScreenDataProviderTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 18.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MainScreenDataProviderTests: XCTestCase {
    let itemsIndentation: CGFloat = 10.0
    var sut: MainScreenDataProvider?
    var collectionView: UICollectionView?
    
    override func setUpWithError() throws {
        sut = MainScreenDataProvider(cellIdentifier: "MainScreenCollectionViewCell")
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
    }
    
    func testNumberOfSectionsIsOne() {
        
    }
}
