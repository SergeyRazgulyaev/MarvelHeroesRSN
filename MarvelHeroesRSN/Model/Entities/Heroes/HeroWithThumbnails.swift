//
//  HeroWithThumbnails.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import Foundation

struct HeroWithThumbnails: Codable {
	let id: Int
	let name: String
	let description: String
	let thumbnail: HeroThumbnail
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case description = "description"
		case thumbnail = "thumbnail"
	}
}
