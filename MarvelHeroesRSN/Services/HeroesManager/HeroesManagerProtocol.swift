//
//  HeroesManagerProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 15.11.2021.
//

import Foundation

protocol HeroesManagerProtocol {
    func clearHeroesStorage()
    func getHero(byID id: Int) -> Hero?
    func getAllHeroesFromStorage() -> [Hero]
    func fillHeroesStorage(withDataFromNetwork heroesNetworkData: [HeroWithThumbnails],
                   isRefreshingData: Bool,
                   isCutOffUnsuccessfulHeroesCard: Bool)
}
