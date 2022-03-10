//
//  NetworkServiceDelegate.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 14.10.2021.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
	func configureUIViewControllerWithoutNetworkConnection()
}
