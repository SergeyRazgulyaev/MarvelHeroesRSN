//
//  HeroTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroTests: XCTestCase {
	var testHero: Hero!

	override func setUpWithError() throws {
		testHero = MockHero.hero1
	}

	override func tearDownWithError() throws {
		testHero = nil
	}

	func testInitHeroWithData() {
		XCTAssertNotNil(testHero)
	}

	func testWhenGivenDataSetsData() {
		XCTAssertEqual(testHero?.id, 1)
		XCTAssertEqual(testHero?.name, "TestHeroName1")
		XCTAssertEqual(testHero?.description, "TestHeroDescription1")
		XCTAssertEqual(testHero?.image, UIImage(systemName: "tortoise.fill"))
	}
}
