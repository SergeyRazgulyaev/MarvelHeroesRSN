//
//  SceneDelegate.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.windowScene = windowScene

		let urlParametersContainer = startURLParametersContainer
		let networkService = NetworkService(urlParametersContainer: urlParametersContainer)
		let heroesManager = HeroesManager()
		let mainScreenDataProvider = MainScreenDataProvider()
		let mainScreenViewController = MainScreenViewController(
			networkService: networkService,
			heroesManager: heroesManager,
			dataProvider: mainScreenDataProvider)
		networkService.delegate = mainScreenViewController
		mainScreenDataProvider.owningViewController = mainScreenViewController
		mainScreenDataProvider.heroesManager = heroesManager

		let navigationController = UINavigationController(rootViewController: mainScreenViewController)

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}

