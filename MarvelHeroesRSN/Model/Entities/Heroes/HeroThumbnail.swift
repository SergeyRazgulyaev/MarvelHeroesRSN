//
//  HeroThumbnail.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import Foundation

struct HeroThumbnail: Codable {
	let thumbnailPath: String
	let thumbnailExtension: String

	enum CodingKeys: String, CodingKey {
		case thumbnailPath = "path"
		case thumbnailExtension = "extension"
	}
}
