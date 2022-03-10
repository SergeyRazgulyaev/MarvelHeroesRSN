//
//  HeroTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroTests: XCTestCase {
    var hero: Hero!
    
    override func setUpWithError() throws {
		hero = MockHero.hero1
    }
    
    override func tearDownWithError() throws {
        hero = nil
    }
    
    func testInitHeroWithData() {
        XCTAssertNotNil(hero)
    }
    
    func testWhenGivenDataSetsData() {
        XCTAssertEqual(hero?.id, 1)
        XCTAssertEqual(hero?.name, "TestHeroName1")
        XCTAssertEqual(hero?.description, "TestHeroDescription1")
        XCTAssertEqual(hero?.image, UIImage(systemName: "tortoise.fill"))
    }
}
