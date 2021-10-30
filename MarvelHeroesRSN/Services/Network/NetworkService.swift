//
//  NetworkService.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import Foundation
import UIKit

class NetworkService: NetworkServiceProtocol {
    //MARK: - Properties for Interaction with Network
    static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private var urlParametersContainer: URLParametersContainer
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlParametersContainer.urlScheme
        urlComponents.host = urlParametersContainer.baseURL
        urlComponents.path = urlParametersContainer.urlPath
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: "\(urlParametersContainer.ts)"),
            URLQueryItem(name: "apikey", value: "\(urlParametersContainer.apiKey)"),
            URLQueryItem(name: "hash", value: "\(urlParametersContainer.hash)"),
            URLQueryItem(name: "limit", value: "\(urlParametersContainer.limit)"),
            URLQueryItem(name: "offset", value: "\(urlParametersContainer.offset)")
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
    func loadHeroesData(limit: Int, offset: Int, completion: ((Result<[HeroWithThumbnails], Error>) -> Void)? = nil) {
        configureURLParametersContainerWith(limit: limit, offset: offset)
        let url = urlComponents.url?.absoluteURL
        guard let url = url else {
            return
        }
        let task = NetworkService.session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                self.delegate?.configureUIViewControllerWithoutNetworkConnection()
                return
            }
            do {
                let heroes = try JSONDecoder().decode(GetHeroesResult.self, from: data).heroesData.results
                completion?(.success(heroes))
            } catch {
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        }
        task.resume()
    }
    
    private func configureURLParametersContainerWith(limit: Int, offset: Int) {
        urlParametersContainer.limit = limit
        urlParametersContainer.offset = offset
    }
}
