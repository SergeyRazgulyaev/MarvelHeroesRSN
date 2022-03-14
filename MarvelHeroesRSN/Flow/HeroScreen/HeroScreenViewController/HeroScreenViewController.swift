//
//  HeroScreenViewController.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import UIKit

final class HeroScreenViewController: UIViewController {
	//MARK: - UI properties
	private(set) lazy var heroScreenView: HeroScreenView = {
		return HeroScreenView()
	}()

	//MARK: - Properties
	private let hero: Hero?

	//MARK: - Init
	init(hero: Hero) {
		self.hero = hero
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - ViewController lifecycle
	override func loadView() {
		view = heroScreenView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}

	//MARK: - Configuration Methods
	func configureUI() {
		heroScreenView.configureViewWith(hero: hero)
	}
}
