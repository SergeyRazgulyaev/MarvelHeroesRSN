//
//  MainScreenView.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class MainScreenView: UIView {
    //MARK: - UI properties
    private let itemsIndentation: CGFloat = 10.0
    private let headerViewHeight: CGFloat = 90.0
    private let heroNameLabelHeight: CGFloat = 25.0
    private let loadingDataStatusLabelHeight: CGFloat = 30.0
    private let loadingActivityIndicatorCenterOffset: CGFloat = 100.0
    
    //MARK: - UI components
    private(set) lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Marvel Heroes"
        label.font = UIFont(name: "AvenirNext-Bold", size: 40.0)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        
        label.layer.cornerRadius = 12.0
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = itemsIndentation
        layout.minimumInteritemSpacing = itemsIndentation / 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private(set) lazy var loadingDataStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading data..."
        label.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        label.layer.cornerRadius = 12.0
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureViewForTesting()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration methods
    func configureUI() {
        backgroundColor = .black
    }
    
    func configureViewForTesting() {
        accessibilityIdentifier = "mainScreenView"
    }
    
    func configureSubviews() {
        addSubview(headerView)
        addSubview(collectionView)
        addSubview(loadingDataStatusLabel)
        addSubview(loadingActivityIndicator)
        headerView.addSubview(headerLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            headerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
            
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,
                                                constant: -itemsIndentation),
            headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                constant: -itemsIndentation),
            headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                               constant: itemsIndentation),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -(loadingDataStatusLabelHeight + itemsIndentation)),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,
                                                  constant: -itemsIndentation),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,
                                                 constant: itemsIndentation),
            
            loadingDataStatusLabel.heightAnchor.constraint(equalToConstant: loadingDataStatusLabelHeight),
            loadingDataStatusLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loadingDataStatusLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,
                                                          constant: -itemsIndentation),
            loadingDataStatusLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,
                                                         constant: itemsIndentation),
            
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: loadingDataStatusLabel.centerXAnchor, constant: -loadingActivityIndicatorCenterOffset),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: loadingDataStatusLabel.centerYAnchor)
        ])
    }
    
    //MARK: - Get methods
    func getItemsIndentation() -> CGFloat {
        return itemsIndentation
    }
    
    func getHeroNameLabelHeight() -> CGFloat {
        return heroNameLabelHeight
    }
}
