//
//  DateFormatterService.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 13.10.2021.
//

import Foundation

class DateFormatterService: DateFormatterServiceProtocol {
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        return dateFormatter
    }()
    
    func getStringFromDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
