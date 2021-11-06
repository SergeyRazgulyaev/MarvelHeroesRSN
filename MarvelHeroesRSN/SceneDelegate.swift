//
//  SceneDelegate.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let urlScheme = "https"
        let baseURL = "gateway.marvel.com"
        let urlPath = "/v1/public/characters"
        let urlTS = 1
        let urlApiKey = "2acb17a14fab947ec914f6731a6f3585"
        let urlHash = "7a082702e822cdb6e752c8ca132ccd92"
        let limit = 50
        let offset = 0
        
        let urlParametersContainer = URLParametersContainer(urlScheme: urlScheme,
                                                            baseURL: baseURL,
                                                            urlPath: urlPath,
                                                            ts: urlTS,
                                                            apiKey: urlApiKey,
                                                            hash: urlHash,
                                                            limit: limit,
                                                            offset: offset)
        let networkService = NetworkService(urlParametersContainer: urlParametersContainer)
        let mainScreenViewController = MainScreenViewController(networkService: networkService)
        networkService.delegate = mainScreenViewController
        
        let navigationController = UINavigationController(rootViewController: mainScreenViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

