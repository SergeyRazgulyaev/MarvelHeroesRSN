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
    var heroWithThumbnails: HeroWithThumbnails?
    var heroesWithThumbnailsTestArray: [HeroWithThumbnails]?
    var heroesTestArray: [Hero]?
    
    override func setUp() {
        sut = HeroesManager()
        heroWithThumbnails = HeroWithThumbnails(id: 1009144,
                                                name: "A.I.M.",
                                                description: "AIM is a terrorist organization bent on destroying the world.",
                                                thumbnail: HeroThumbnail(thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
                                                                         thumbnailExtension: "jpg"))
        heroesWithThumbnailsTestArray = []
        heroesTestArray = []
    }
    
    override func tearDown() {
        sut = nil
        heroWithThumbnails = nil
        heroesWithThumbnailsTestArray = nil
        heroesTestArray = nil
    }
    
    func testHeroesWithThumbnailsTestArrayCount() throws {
        heroesWithThumbnailsTestArray?.append(heroWithThumbnails!)
        XCTAssertEqual(heroesWithThumbnailsTestArray?.count, 1)
    }
    
    func testGetFilteredHeroesArrayCount() throws {
        heroesWithThumbnailsTestArray?.append(heroWithThumbnails!)
        heroesTestArray = sut?.getHeroes(fromHeroesNetworkData: heroesWithThumbnailsTestArray ?? [],
                                         isRefreshingData: false,
                                         isCutOffUnsuccessfulHeroesCard: true)
        XCTAssertEqual(heroesTestArray?.count, 1)
    }
    
    func testHeroByIDFromHeroesManager() throws {
        
    }
    
}
