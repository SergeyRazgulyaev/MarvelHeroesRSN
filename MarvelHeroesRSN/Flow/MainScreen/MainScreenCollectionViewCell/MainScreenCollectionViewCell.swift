//
//  MainScreenCollectionViewCell.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    //MARK: - UI properties
	static let cellIdentifier: String = String(describing: self)
	
    private let heroNameLabelHeight: CGFloat = 25.0
    
    //MARK: - UI components
    private(set) lazy var heroAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration methods
    private func configureCell() {
        layer.cornerRadius = 12.0
        layer.masksToBounds = true
    }
    
    private func configureSubviews() {
        addSubview(heroAvatarImageView)
        addSubview(heroNameLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heroAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroAvatarImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            heroAvatarImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            heroAvatarImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -heroNameLabelHeight),
            
            heroNameLabel.topAnchor.constraint(equalTo: heroAvatarImageView.bottomAnchor),
            heroNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            heroNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            heroNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureCellWithParametersFromNetwork(heroAvatarImage: UIImage,
                                                heroName: String) {
        heroAvatarImageView.image = heroAvatarImage
        heroNameLabel.text = heroName
    }
}
