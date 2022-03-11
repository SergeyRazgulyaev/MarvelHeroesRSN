//
//  Alertable.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 14.10.2021.
//

import UIKit

protocol Alertable {
	func showAttantionAlert(viewController: UIViewController,
							message: String,
							handler: @escaping ((UIAlertAction) -> ()),
							completion: @escaping (() -> Void))
}

extension Alertable {
	func showAttantionAlert(viewController: UIViewController,
							message: String,
							handler: @escaping ((UIAlertAction) -> ()),
							completion: @escaping (() -> Void)) {
		let alertController = UIAlertController(title: "Attention",
												message: message,
												preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK",
									 style: .default,
									 handler: handler)
		alertController.addAction(okAction)
		viewController.present(alertController,
							   animated: true,
							   completion: completion)
	}
}
