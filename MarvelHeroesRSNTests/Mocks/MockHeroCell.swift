//
//  MockHeroCell.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import UIKit
@testable import MarvelHeroesRSN

final class MockHeroCell: MainScreenCollectionViewCell {
	override func configureCellWithParametersFromNetwork(heroAvatarImage: UIImage, heroName: String) {
		print("configureCell")
		heroNameLabel.text = heroName
		heroAvatarImageView.image = heroAvatarImage
	}
}
