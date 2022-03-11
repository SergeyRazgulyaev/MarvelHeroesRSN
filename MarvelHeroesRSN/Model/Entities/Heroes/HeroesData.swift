//
//  HeroesData.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import Foundation

struct HeroesData: Codable {
	let offset: Int
	let limit: Int
	let total: Int
	let count: Int
	let results: [HeroWithThumbnails]

	enum CodingKeys: String, CodingKey {
		case offset = "offset"
		case limit = "limit"
		case total = "total"
		case count = "count"
		case results = "results"
	}
}
