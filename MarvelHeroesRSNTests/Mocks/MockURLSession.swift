//
//  MockURLSession.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 14.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

class MockURLSession: URLSessionProtocol {
	var url: URL?

	func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		self.url = url
		return URLSession.shared.dataTask(with: url)
	}
}
