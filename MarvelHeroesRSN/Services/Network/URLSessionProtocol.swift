//
//  URLSessionProtocol.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 14.03.2022.
//

import Foundation

protocol URLSessionProtocol {	
	func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
