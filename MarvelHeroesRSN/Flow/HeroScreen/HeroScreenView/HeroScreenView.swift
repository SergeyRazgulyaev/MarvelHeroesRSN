//
//  HeroScreenView.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 12.10.2021.
//

import UIKit

final class HeroScreenView: UIView {
	//MARK: - UI properties
	private var heroAvatarViewHeight: CGFloat { UIScreen.main.bounds.width }
	private let heroNameLabelHeight: CGFloat = 60.0
	private var heroDescriptionTextViewHeight: CGFloat = 250.0
	private var stackViewHeight: CGFloat {
		heroAvatarViewHeight + heroNameLabelHeight + heroDescriptionTextViewHeight
	}
	
	//MARK: - UI components
	private(set) lazy var scrollView: UIScrollView = {
		let screenSize: CGRect = UIScreen.main.bounds
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		let scrollView = UIScrollView()
		scrollView.contentSize = CGSize(width: screenWidth,
										height: screenHeight)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private(set) lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private(set) lazy var heroAvatarView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.heightAnchor.constraint(equalToConstant: heroAvatarViewHeight).isActive = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private(set) lazy var heroNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "AvenirNext-Bold", size: 40.0)
		label.textAlignment = .center
		label.textColor = .white
		label.adjustsFontSizeToFitWidth = true
		label.backgroundColor = .systemRed
		label.heightAnchor.constraint(equalToConstant: heroNameLabelHeight).isActive = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private(set) lazy var heroDescriptionTextView: UITextView = {
		let textView = UITextView()
		textView.font = UIFont(name: "Avenir Next", size: 20.0)
		textView.isEditable = false
		textView.textAlignment = .center
		textView.backgroundColor = .black
		textView.textColor = .white
		textView.heightAnchor.constraint(equalToConstant: heroDescriptionTextViewHeight).isActive = true
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureStackView()
		configureSubviews()
		configureConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Configuration methods
	private func configureStackView() {
		stackView.addArrangedSubview(heroAvatarView)
		stackView.addArrangedSubview(heroNameLabel)
		stackView.addArrangedSubview(heroDescriptionTextView)
	}
	
	private func configureSubviews() {
		addSubview(scrollView)
		scrollView.addSubview(stackView)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
			stackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor)
		])
	}
	
	func configureViewWith(hero: Hero?) {
		guard let hero = hero else { return }
		heroAvatarView.image = hero.image
		heroNameLabel.text = hero.name
		if hero.description.isEmpty {
			heroDescriptionTextView.text = "No description for the hero"
		} else {
			heroDescriptionTextView.text = "\(hero.name):\n\(hero.description)"
		}
	}
}
