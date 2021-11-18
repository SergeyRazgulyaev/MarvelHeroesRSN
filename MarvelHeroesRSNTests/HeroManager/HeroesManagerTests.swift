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
    var heroWithCrashedExtensionThumbnails: HeroWithThumbnails?
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
        heroWithCrashedExtensionThumbnails = HeroWithThumbnails(id: 4,
                                                            name: "testName4",
                                                            description: "testDescription4",
                                                            thumbnail: HeroThumbnail(thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                                                                                     thumbnailExtension: "crashedExtension"))
        heroesWithThumbnailsTestArray = []
        heroesWithThumbnailsTestArray?.append(heroWithGoodThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadPathThumbnails!)
        heroesWithThumbnailsTestArray?.append(heroWithBadExtensionThumbnails!)
        heroesTestArray = []
    }
    
    override func tearDown() {
        sut = nil
        heroWithGoodThumbnails = nil
        heroWithBadPathThumbnails = nil
        heroWithBadExtensionThumbnails = nil
        heroWithCrashedExtensionThumbnails = nil
        heroesWithThumbnailsTestArray = nil
        heroesTestArray = nil
    }
    
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
        XCTAssertEqual(hero?.name, "testName2")
        XCTAssertEqual(hero?.description, "testDescription2")
    }
    
    func testGenNilHeroByIDFromHeroesManager() {
        heroesWithThumbnailsTestArray = []
        sut?.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: false)
        heroesTestArray = sut?.getAllHeroesFromStorage()
        let hero = sut?.getHero(byID: 1)
        XCTAssertEqual(hero, nil)
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
