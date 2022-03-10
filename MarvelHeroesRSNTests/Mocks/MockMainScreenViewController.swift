//
//  MockMainScreenViewController.swift
//  MarvelHeroesRSNTests
//
//  Created by Sergey Razgulyaev on 10.03.2022.
//

import Foundation
@testable import MarvelHeroesRSN

final class MockMainScreenViewController: MainScreenViewController {
	override var mainScreenView: MainScreenView {
		return MockMainScreenView()
	}
}
