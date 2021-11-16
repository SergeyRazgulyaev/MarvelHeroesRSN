//
//  HeroesManager.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import UIKit

class HeroesManager: HeroesManagerProtocol {
    private var heroesStorage: [Hero] = []
    
    func getHero(byID id: Int) -> Hero? {
        guard let hero = heroesStorage.filter({ $0.id == id }).first else { return nil }
        return hero
    }
    
    func makeHeroesArray(fromHeroesNetworkData heroesNetworkData: [HeroWithThumbnails],
                         isRefreshingData: Bool,
                         isCutOffUnsuccessfulHeroesCard: Bool) -> [Hero] {
        var tempArray: [Hero] = []
        if isRefreshingData {
            heroesStorage = []
        }
        if isCutOffUnsuccessfulHeroesCard {
            for heroNetworkData in heroesNetworkData {
                if !heroNetworkData.thumbnail.thumbnailPath.contains("image_not_available") && heroNetworkData.thumbnail.thumbnailExtension != "gif" {
                    if let hero = makeHero(fromHeroNetworkData: heroNetworkData) {
                        tempArray.append(hero)
                    }
                }
            }
        } else {
            for heroNetworkData in heroesNetworkData {
                if let hero = makeHero(fromHeroNetworkData: heroNetworkData) {
                    tempArray.append(hero)
                }
            }
        }
        heroesStorage += tempArray
        return heroesStorage
        
    }
    
    private func makeHero(fromHeroNetworkData heroNetworkData: HeroWithThumbnails) -> Hero? {
        let thumbnailPathWithExtension = heroNetworkData.thumbnail.thumbnailPath + "." + heroNetworkData.thumbnail.thumbnailExtension
        guard let url = URL(string: thumbnailPathWithExtension),
              let data = try? Data(contentsOf: url),
              let heroAvatarImage = UIImage(data: data) else { return nil }
        
        let hero = Hero(id: heroNetworkData.id,
                        name: heroNetworkData.name,
                        description: heroNetworkData.description,
                        image: heroAvatarImage)
        return hero
    }
}
