//
//  NetworkService.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import UIKit

final class NetworkService: NetworkServiceProtocol {
	//MARK: - Properties for Interaction with Network
	static let session: URLSession = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 20
		let session = URLSession(configuration: configuration)
		return session
	}()

	private(set) var isDataLoading: Bool = false
	private var urlParametersContainer: URLParametersContainer
	private var urlComponents: URLComponents {
		var urlComponents = URLComponents()
		urlComponents.scheme = urlParametersContainer.urlScheme
		urlComponents.host = urlParametersContainer.baseURL
		urlComponents.path = urlParametersContainer.urlPath
		urlComponents.queryItems = [
			URLQueryItem(name: "ts",
						 value: "\(urlParametersContainer.ts)"),
			URLQueryItem(name: "apikey",
						 value: "\(urlParametersContainer.apiKey)"),
			URLQueryItem(name: "hash",
						 value: "\(urlParametersContainer.hash)"),
			URLQueryItem(name: "limit",
						 value: "\(urlParametersContainer.limit ?? 1)"),
			URLQueryItem(name: "offset",
						 value: "\(urlParametersContainer.offset ?? 0)")
		]
		return urlComponents
	}

	//MARK: - Delegate Property
	weak var delegate: NetworkServiceDelegate?

	//MARK: - Init
	init(urlParametersContainer: URLParametersContainer) {
		self.urlParametersContainer = urlParametersContainer
	}

	//MARK: - Methods for loading Heroes Data from Network
	/// Loading data about heroes from the open Marvel API
	/// - Parameters:
	///   - limit: one-time download limit for heroes
	///   - offset: load offset from first hero
	///   - completion: closure with load result
	func loadHeroesData(limit: Int,
						offset: Int,
						completion: @escaping (Result<[HeroWithThumbnails], Error>) -> Void) {
		setLoadingStatusTrue()
		configureURLParametersContainerWith(limit: limit, offset: offset)
		let url = urlComponents.url?.absoluteURL
		guard let url = url else { return }
		let task = NetworkService.session.dataTask(with: url) { (data, response, error) in
			guard let data = data else {
				self.delegate?.configureUIViewControllerWithoutNetworkConnection()
				return
			}

			do {
				let heroes = try JSONDecoder().decode(GetHeroesResult.self,
													  from: data).heroesData.results
				completion(.success(heroes))
			} catch {
				print(error.localizedDescription)
				completion(.failure(error))
			}

			self.setLoadingStatusFalse()
		}
		task.resume()
	}

	private func configureURLParametersContainerWith(limit: Int, offset: Int) {
		urlParametersContainer.limit = limit
		urlParametersContainer.offset = offset
	}

	private func setLoadingStatusTrue() {
		isDataLoading = true
	}

	private func setLoadingStatusFalse() {
		isDataLoading = false
	}
}
