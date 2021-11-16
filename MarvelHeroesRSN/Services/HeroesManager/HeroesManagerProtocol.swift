//
//  HeroesManagerProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import Foundation

protocol HeroesManagerProtocol {
    var heroesStorage: [Hero] { get }
    
    func getHero(byID id: Int) -> Hero?
    func getHeroes(fromHeroesNetworkData heroesNetworkData: [HeroWithThumbnails],
                   isRefreshingData: Bool,
                   isCutOffUnsuccessfulHeroesCard: Bool) -> [Hero]
    
}
