//
//  HeroTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroTests: XCTestCase {
    var hero: Hero?
    
    override func setUpWithError() throws {
        hero = Hero(id: 1,
                        name: "TestHeroName",
                        description: "TestHeroDescription",
                        image: UIImage(systemName: "tortoise.fill")!)
    }
    
    override func tearDownWithError() throws {
        hero = nil
    }
    
    func testInitHeroWithData() {
        XCTAssertNotNil(hero)
    }
    
    func testWhenGivenDataSetsData() {
        XCTAssertEqual(hero?.id, 1)
        XCTAssertEqual(hero?.name, "TestHeroName")
        XCTAssertEqual(hero?.description, "TestHeroDescription")
        XCTAssertEqual(hero?.image, UIImage(systemName: "tortoise.fill"))
    }
}
