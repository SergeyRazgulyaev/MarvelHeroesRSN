//
//  HeroesManagerProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import Foundation

protocol HeroesManagerProtocol {    
//    func getFilteredHeroesArray(fromHeroesWithThumbnails heroesWithThumbnails: [HeroWithThumbnails], isRefreshingData: Bool) -> [Hero]
    
    func getHeroes(fromHeroesNetworkData heroesNetworkData: [HeroWithThumbnails],
                   isRefreshingData: Bool,
                   isCutOffUnsuccessfulHeroesCard: Bool) -> [Hero]
    
}
