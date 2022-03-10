//
//  HeroesManagerTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroesManagerTests: XCTestCase {
    var sut: HeroesManagerProtocol!

    var heroWithGoodThumbnails: HeroWithThumbnails!
    var heroWithBadPathThumbnails: HeroWithThumbnails!
    var heroWithBadExtensionThumbnails: HeroWithThumbnails!
    var heroWithCrashedExtensionThumbnails: HeroWithThumbnails!
    var heroesWithThumbnailsTestArray: [HeroWithThumbnails]!

    var heroesTestArray: [Hero]!
    
    override func setUpWithError() throws {
        sut = HeroesManager()

		heroWithGoodThumbnails = MockHeroFromNetwork.heroWithGoodThumbnails
		heroWithBadPathThumbnails = MockHeroFromNetwork.heroWithBadPathThumbnails
		heroWithBadExtensionThumbnails = MockHeroFromNetwork.heroWithBadExtensionThumbnails
		heroWithCrashedExtensionThumbnails = MockHeroFromNetwork.heroWithCrashedExtensionThumbnails

        heroesWithThumbnailsTestArray = []
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)

        heroesTestArray = []
    }
    
    override func tearDownWithError() throws {
        heroWithGoodThumbnails = nil
        heroWithBadPathThumbnails = nil
        heroWithBadExtensionThumbnails = nil
        heroWithCrashedExtensionThumbnails = nil
        heroesWithThumbnailsTestArray = nil
        heroesTestArray = nil
		sut = nil
    }

    // MARK: - Tests that work only with Network
    func testGetFilteredHeroesArrayCount() throws {
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: true)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        XCTAssertEqual(heroesTestArray?.count, 1)
    }
    
    func testGetAllHeroesArrayCount() throws {
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        XCTAssertEqual(heroesTestArray?.count, 3)
    }
    
    func testGetHeroByIDFromHeroesManager() {
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        let hero = sut?.getHero(byID: 2)
        XCTAssertEqual(hero?.id, 2)
        XCTAssertEqual(hero?.name, "TestHeroName2")
        XCTAssertEqual(hero?.description, "TestHeroDescription2")
		
    }

    func testGetHeroByNameFromHeroesManager() {
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        let hero = sut?.getHero(byName: "TestHeroName2")
        XCTAssertEqual(hero?.id, 2)
        XCTAssertEqual(hero?.name, "TestHeroName2")
        XCTAssertEqual(hero?.description, "TestHeroDescription2")
    }

	func testIsHeroesArrayEmptyWhenRefresh() {
		heroesWithThumbnailsTestArray = []
		heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
		sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
										 isRefreshingData: false,
										 isCutOffUnsuccessfulHeroesCard: false)
		heroesTestArray = sut?.getAllHeroesFromStorage()
		XCTAssertEqual(heroesTestArray?.count, 1)

		sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
										 isRefreshingData: false,
										 isCutOffUnsuccessfulHeroesCard: false)
		heroesTestArray = sut?.getAllHeroesFromStorage()
		XCTAssertEqual(heroesTestArray?.count, 2)

		sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
										 isRefreshingData: true,
										 isCutOffUnsuccessfulHeroesCard: false)
		heroesTestArray = sut?.getAllHeroesFromStorage()
		XCTAssertEqual(heroesTestArray?.count, 1)
	}

	// MARK: - Tests that work without Network
	func testGenNilHeroByIDFromHeroesManager() {
			heroesWithThumbnailsTestArray = []
			sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
											 isRefreshingData: false,
											 isCutOffUnsuccessfulHeroesCard: false)
			heroesTestArray = sut?.getAllHeroesFromStorage()
			let hero = sut?.getHero(byID: 1)
			XCTAssertEqual(hero, nil)
		}
    func testGenNilHeroByNameFromHeroesManager() {
        heroesWithThumbnailsTestArray = []
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        let hero = sut?.getHero(byName: "TestHeroName1")
        XCTAssertEqual(hero, nil)
    }
    
    func testNilHeroWhenMakeHeroWithCrashedThumbnails() {
        heroesWithThumbnailsTestArray = []
        heroesWithThumbnailsTestArray?.append(heroWithCrashedExtensionThumbnails!)
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        let hero = sut?.getHero(byID: 4)
        XCTAssertEqual(hero, nil)
    }
}
