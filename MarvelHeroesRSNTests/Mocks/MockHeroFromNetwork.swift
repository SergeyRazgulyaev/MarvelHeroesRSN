//
//  MockHeroFromNetwork.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

struct MockHeroFromNetwork {
	static let heroWithGoodThumbnails = HeroWithThumbnails(
		id: 1,
		name: "TestHeroName1",
		description: "TestHeroDescription1",
		thumbnail: HeroThumbnail(
			thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
			thumbnailExtension: "jpg")
	)

	static let heroWithBadPathThumbnails = HeroWithThumbnails(
		id: 2,
		name: "TestHeroName2",
		description: "TestHeroDescription2",
		thumbnail: HeroThumbnail(
			thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
			thumbnailExtension: "jpg")
	)

	static let heroWithBadExtensionThumbnails = HeroWithThumbnails(
		id: 3,
		name: "TestHeroName3",
		description: "TestHeroDescription3",
		thumbnail: HeroThumbnail(
			thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/5/e0/4c0035c9c425d",
			thumbnailExtension: "gif")
	)

	static let heroWithCrashedExtensionThumbnails = HeroWithThumbnails(
		id: 4,
		name: "TestHeroName4",
		description: "TestHeroDescription4",
		thumbnail: HeroThumbnail(
			thumbnailPath: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec",
			thumbnailExtension: "crashedExtension")
	)
}
