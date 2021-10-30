//
//  DateFormatterServiceProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.10.2021.
//

import Foundation

protocol DateFormatterServiceProtocol {
    func getStringFromDate(date: Date) -> String
}
