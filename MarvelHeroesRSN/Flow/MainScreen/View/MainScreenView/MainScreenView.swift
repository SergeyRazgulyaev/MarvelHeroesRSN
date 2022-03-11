//
//  MainScreenView.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class MainScreenView: UIView {
	//MARK: - UI properties
	static let heroNameLabelHeight: CGFloat = 25.0
	private let headerViewHeight: CGFloat = 90.0
	private let loadingDataStatusLabelHeight: CGFloat = 30.0
	private let loadingActivityIndicatorCenterOffset: CGFloat = 100.0

	private let indentationBetweenCollectionViewItems: CGFloat = 10.0
	private let indentationBetweenCells: CGFloat = 4.0
	private let numberOfCellsInCollectionViewRow: Int = 3
	private var imageInCellWidthAndHeight: CGFloat {
		return (bounds.width - (2 * indentationBetweenCollectionViewItems)) / CGFloat(numberOfCellsInCollectionViewRow) - indentationBetweenCells * CGFloat(numberOfCellsInCollectionViewRow - 1)
	}
	private(set) lazy var collectionViewItemWidth: CGFloat = {
		imageInCellWidthAndHeight
	}()
	private(set) lazy var collectionViewItemHeight: CGFloat = {
		return imageInCellWidthAndHeight + MainScreenView.heroNameLabelHeight
	}()

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
		layout.minimumLineSpacing = indentationBetweenCollectionViewItems
		layout.minimumInteritemSpacing = indentationBetweenCollectionViewItems
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
			// headerView
			headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			headerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			headerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),

			// headerLabel
			headerLabel.topAnchor.constraint(
				equalTo: headerView.topAnchor),
			headerLabel.bottomAnchor.constraint(
				equalTo: headerView.bottomAnchor,
				constant: -indentationBetweenCollectionViewItems),
			headerLabel.rightAnchor.constraint(
				equalTo: headerView.rightAnchor,
				constant: -indentationBetweenCollectionViewItems),
			headerLabel.leftAnchor.constraint(
				equalTo: headerView.leftAnchor,
				constant: indentationBetweenCollectionViewItems),

			// collectionView
			collectionView.topAnchor.constraint(
				equalTo: headerView.bottomAnchor),
			collectionView.bottomAnchor.constraint(
				equalTo: safeAreaLayoutGuide.bottomAnchor,
				constant: -(loadingDataStatusLabelHeight + indentationBetweenCollectionViewItems)),
			collectionView.rightAnchor.constraint(
				equalTo: safeAreaLayoutGuide.rightAnchor,
				constant: -indentationBetweenCollectionViewItems),
			collectionView.leftAnchor.constraint(
				equalTo: safeAreaLayoutGuide.leftAnchor,
				constant: indentationBetweenCollectionViewItems),
			
			// loadingDataStatusLabel
			loadingDataStatusLabel.heightAnchor.constraint(
				equalToConstant: loadingDataStatusLabelHeight),
			loadingDataStatusLabel.bottomAnchor.constraint(
				equalTo: safeAreaLayoutGuide.bottomAnchor),
			loadingDataStatusLabel.rightAnchor.constraint(
				equalTo: safeAreaLayoutGuide.rightAnchor,
				constant: -indentationBetweenCollectionViewItems),
			loadingDataStatusLabel.leftAnchor.constraint(
				equalTo: safeAreaLayoutGuide.leftAnchor,
				constant: indentationBetweenCollectionViewItems),

			// loadingActivityIndicator
			loadingActivityIndicator.centerXAnchor.constraint(
				equalTo: loadingDataStatusLabel.centerXAnchor,
				constant: -loadingActivityIndicatorCenterOffset),
			loadingActivityIndicator.centerYAnchor.constraint(
				equalTo: loadingDataStatusLabel.centerYAnchor)
		])
	}
}
