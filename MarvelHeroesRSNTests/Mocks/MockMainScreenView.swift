//
//  MockMainScreenView.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import UIKit
@testable import MarvelHeroesRSN

final class MockMainScreenView: MainScreenView {
	override var collectionView: UICollectionView {
		let mockCollectionView = MockCollectionView(frame: .zero,
													collectionViewLayout: UICollectionViewFlowLayout())
		return mockCollectionView
	}
}
