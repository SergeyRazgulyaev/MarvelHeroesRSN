//
//  MarvelHeroesRSNTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 12.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class MarvelHeroesRSNTests: XCTestCase {
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
    
    override func setUp() {
        super.setUp()
        networkService?.delegate = sut
    }

    override func tearDown() {
        networkService = nil
        sut = nil
        super.tearDown()
    }
    
    func testMainScreenVC() {
        sut?.loadHeroesDataFromNetWorkIfNeeded()
    }
}
