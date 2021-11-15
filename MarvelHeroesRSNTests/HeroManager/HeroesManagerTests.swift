//
//  HeroesManagerTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroesManagerTests: XCTestCase {
    var sut: HeroesManagerProtocol? = HeroesManager()
    
    override func setUp() {
        
    }

    override func tearDown() {
       sut = nil
    }

    func testInitHeroesManagerWithEmptyHeroes() throws {

    }

}
