//
//  MockCollectionView.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import UIKit
@testable import MarvelHeroesRSN

final class MockCollectionView: UICollectionView {
	let itemsIndentation: CGFloat = 10.0

	var isCellForItemAtZeroIndexPathActivated = false
	var cellIsDequeued = false

	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = itemsIndentation
		layout.minimumInteritemSpacing = itemsIndentation
		layout.itemSize = CGSize(width: 100, height: 100)
		super.init(frame: .zero,
				   collectionViewLayout: layout)
		register(MockHeroCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.cellIdentifier)
		backgroundColor = .black
		translatesAutoresizingMaskIntoConstraints = false
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
		isCellForItemAtZeroIndexPathActivated = true
		return super.cellForItem(at: indexPath)
	}

	override func dequeueReusableCell(withReuseIdentifier identifier: String,
									  for indexPath: IndexPath)
	-> UICollectionViewCell {
		cellIsDequeued = true
		return super.dequeueReusableCell(withReuseIdentifier: identifier,
										 for: indexPath)
	}
}
