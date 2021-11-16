//
//  HeroesManagerProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import Foundation

protocol HeroesManagerProtocol {    
    func getHero(byID id: Int) -> Hero?
    func makeHeroesArray(fromHeroesNetworkData heroesNetworkData: [HeroWithThumbnails],
                   isRefreshingData: Bool,
                   isCutOffUnsuccessfulHeroesCard: Bool) -> [Hero]
    
}
