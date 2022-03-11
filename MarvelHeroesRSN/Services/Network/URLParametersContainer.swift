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
	var limit: Int?
	var offset: Int?
}

let startURLParametersContainer = URLParametersContainer(
	urlScheme: "https",
	baseURL: "gateway.marvel.com",
	urlPath: "/v1/public/characters",
	ts: 1,
	apiKey: "2acb17a14fab947ec914f6731a6f3585",
	hash: "7a082702e822cdb6e752c8ca132ccd92",
	limit: 50,
	offset: 0)
