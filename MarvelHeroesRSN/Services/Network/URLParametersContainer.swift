//
//  URLParametersContainer.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 19.10.2021.
//

import Foundation

struct URLParametersContainer {
    var urlScheme: String
    var baseURL: String
    var urlPath: String
    var ts: Int
    var apiKey: String
    var hash: String
    var limit: Int
    var offset: Int
}
