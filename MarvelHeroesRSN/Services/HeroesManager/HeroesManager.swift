//
//  HeroesManager.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import UIKit

class HeroesManager: HeroesManagerProtocol {
    private var heroes: [Hero] = []
    
    func getFilteredHeroesArray(fromHeroesWithThumbnails heroesWithThumbnails: [HeroWithThumbnails], isRefreshingData: Bool) -> [Hero] {
        if isRefreshingData {
            heroes = []
        }
        
        for heroWithThumbnails in heroesWithThumbnails {
            if !heroWithThumbnails.thumbnail.thumbnailPath.contains("image_not_available") && heroWithThumbnails.thumbnail.thumbnailExtension != "gif" {
                let thumbnailPathWithExtension = heroWithThumbnails.thumbnail.thumbnailPath + "." + heroWithThumbnails.thumbnail.thumbnailExtension
                
                if let url = URL(string: thumbnailPathWithExtension),
                   let data = try? Data(contentsOf: url),
                   let heroAvatarImage = UIImage(data: data) {
                    let hero = Hero(id: heroWithThumbnails.id,
                                    name: heroWithThumbnails.name,
                                    description: heroWithThumbnails.description,
                                    image: heroAvatarImage)
                    heroes.append(hero)
                }
            }
        }
        return heroes
    }
}
