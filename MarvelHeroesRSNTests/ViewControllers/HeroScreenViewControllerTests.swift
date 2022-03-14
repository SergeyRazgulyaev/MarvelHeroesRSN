//
//  HeroScreenViewControllerTests.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 14.03.2022.
//

import XCTest
@testable import MarvelHeroesRSN

class HeroScreenViewControllerTests: XCTestCase {
	var sut: HeroScreenViewController!

	var testHero: Hero!



	override func setUpWithError() throws {
		testHero = MockHero.hero1
		sut = HeroScreenViewController(hero: testHero)
		sut?.loadViewIfNeeded()

	}

	override func tearDownWithError() throws {
		testHero = nil
		sut = nil
	}

	func testIsViewLoaded() {
		XCTAssertEqual(sut?.isViewLoaded, true)
	}

	func testHeroScreenViewControllerHasHeroAvatarView() {
		XCTAssertNotNil(sut.heroScreenView.heroAvatarView)
	}

	func testHeroAvatarViewValue() {
		XCTAssertEqual(sut.heroScreenView.heroAvatarView.image, UIImage(systemName: "tortoise.fill"))
	}

	func testHeroScreenViewControllerHasHeroNameLabel() {
		XCTAssertNotNil(sut.heroScreenView.heroNameLabel)
	}

	func testHeroNameLabelValue() {
		XCTAssertEqual(sut.heroScreenView.heroNameLabel.text, "TestHeroName1")
	}

	func testHeroScreenViewControllerHasHeroDescriptionTextView() {
		XCTAssertNotNil(sut.heroScreenView.heroDescriptionTextView)

	}

	func testHeroDescriptionTextViewValue() {
		XCTAssertEqual(sut.heroScreenView.heroDescriptionTextView.text, "TestHeroName1:\nTestHeroDescription1")
	}
}
