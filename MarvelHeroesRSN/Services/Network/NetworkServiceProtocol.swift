//
//  NetworkServiceProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.10.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadHeroesData(limit: Int, offset: Int, completion: ((Result<[HeroWithThumbnails], Error>) -> Void)?)
}
