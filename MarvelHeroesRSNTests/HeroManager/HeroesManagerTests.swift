//
//  HeroesManagerTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroesManagerTests: XCTestCase {
    var sut: HeroesManagerProtocol?
    var heroWithGoodThumbnails: HeroWithThumbnails?
    var heroWithBadPathThumbnails: HeroWithThumbnails?
    var heroWithBadExtensionThumbnails: HeroWithThumbnails?
    var heroesWithThumbnailsTestArray: [HeroWithThumbnails]?
    var heroesTestArray: [Hero]?
    
    override func setUp() {
        sut = HeroesManager()
        heroWithGoodThumbnails = HeroWithThumbnails(id: 1,
                                                    name: "testName1",
                                                    description: "testDescription1",
                                                    thumbnail: HeroThumbnail(thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                                                                             thumbnailExtension: "jpg"))
        heroWithBadPathThumbnails = HeroWithThumbnails(id: 2,
                                                       name: "testName2",
                                                       description: "testDescription2",
                                                       thumbnail: HeroThumbnail(thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                                                                                thumbnailExtension: "jpg"))
        heroWithBadExtensionThumbnails = HeroWithThumbnails(id: 3,
                                                            name: "testName3",
                                                            description: "testDescription3",
                                                            thumbnail: HeroThumbnail(thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/5/e0/4c0035c9c425d",
                                                                                     thumbnailExtension: "gif"))
        heroesWithThumbnailsTestArray = []
//        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
//        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
//        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)
        heroesTestArray = []
    }
    
    override func tearDown() {
        sut = nil
        heroWithGoodThumbnails = nil
        heroWithBadPathThumbnails = nil
        heroWithBadExtensionThumbnails = nil
        heroesWithThumbnailsTestArray = nil
        heroesTestArray = nil
    }
    
    func testGetFilteredHeroesArrayCount() throws {
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: true)
        
        XCTAssertEqual(heroesTestArray?.count, 1)
    }
    
    func testGetAllHeroesArrayCount() throws {
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        XCTAssertEqual(heroesTestArray?.count, 3)
    }
    
    func testGetHeroByIDFromHeroesManager() throws {
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        let hero = sut?.getHero(byID: 2)
        XCTAssertEqual(hero?.id, 2)
        XCTAssertEqual(hero?.name, "testName2")
        XCTAssertEqual(hero?.description, "testDescription2")
    }
    
    func testIsHeroesArrayEmptyWhenRefresh() {
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        XCTAssertEqual(heroesTestArray?.count, 1)
        XCTAssertEqual(sut?.heroesStorage.count, 1)
        
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        XCTAssertEqual(heroesTestArray?.count, 2)
        XCTAssertEqual(sut?.heroesStorage.count, 2)
        
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        XCTAssertEqual(heroesTestArray?.count, 3)
        XCTAssertEqual(sut?.heroesStorage.count, 3)
        
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: true,
                                         isCutOffUnsuccessfulHeroesCard: false)
        XCTAssertEqual(heroesTestArray?.count, 1)
        XCTAssertEqual(sut?.heroesStorage.count, 1)
    }
}
