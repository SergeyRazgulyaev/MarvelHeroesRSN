//
//  MainScreenViewController.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class MainScreenViewController: UIViewController, Alertable {
    //MARK: - UI properties
    private lazy var mainScreenView: MainScreenView = {
        return MainScreenView()
    }()
    private lazy var cellWidthAndHeight: CGFloat = { mainScreenView.bounds.width / 3.0 }()
    private let indentationBetweenCells: CGFloat = 0.5
    private let numberOfCellsInCollectionView: Int = 3
    
    //MARK: - Properties
    private let cellIdentifier: String = "MainScreenCollectionViewCell"
    private let cellNumberFromEnd: Int = 4
    private var heroesManager = HeroesManager()
    private var heroes: [Hero] = []
    
    //MARK: - Properties for Interaction with Network
    private let networkService: NetworkServiceProtocol
    private let limit: Int = 50
    private var offset: Int = 0
    private var isDataLoading: Bool = false
    private var isCutOffUnsuccessfulHeroesCard = true
    
    //MARK: - Properties for RefreshController
    private var isRefreshingData: Bool = false
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemGreen
        refreshControl.addTarget(self, action: #selector(reloadHeroesData(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func reloadHeroesData(_ sender: UIRefreshControl) {
        if !isDataLoading {
            self.refreshControl.beginRefreshing()
            isRefreshingData = true
            loadHeroesDataFromNetWork() { [weak self] in
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        } else {
            self.refreshControl.endRefreshing()
        }
    }
    
    //MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController lifecycle
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadHeroesDataFromNetWorkIfNeeded()
    }
    
    //MARK: - Configuration Methods
    func configureViewController() {
        mainScreenView.collectionView.delegate = self
        mainScreenView.collectionView.dataSource = self
        mainScreenView.collectionView.prefetchDataSource = self
        mainScreenView.collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        mainScreenView.collectionView.refreshControl = refreshControl
    }
}

//MARK: - UICollectionViewDataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainScreenCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCellWithParametersFromNetwork(heroAvatarImage: heroes[indexPath.row].image, heroName: heroes[indexPath.row].name)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroScreenViewController = HeroScreenViewController(hero: heroes[indexPath.row])
        navigationController?.pushViewController(heroScreenViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidthAndHeight - indentationBetweenCells * CGFloat(numberOfCellsInCollectionView) * mainScreenView.getItemsIndentation(),
                      height: cellWidthAndHeight - indentationBetweenCells * CGFloat(numberOfCellsInCollectionView) * mainScreenView.getItemsIndentation() + mainScreenView.getHeroNameLabelHeight())
    }
}

//MARK: - UICollectionViewDataSourcePrefetching
extension MainScreenViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell(for:)),
              !isDataLoading else { return }
        loadHeroesDataFromNetWork()
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == (heroes.count - cellNumberFromEnd)
    }
}

//MARK: - Interaction with Network
extension MainScreenViewController {
    func loadHeroesDataFromNetWorkIfNeeded() {
        if heroes.isEmpty {
            loadHeroesDataFromNetWork()
        }
    }
    
    func loadHeroesDataFromNetWork(completion: (() -> Void)? = nil) {
        isDataLoading = true
        if isRefreshingData {
            self.offset = 0
        }
        DispatchQueue.main.async {
            self.mainScreenView.loadingDataStatusLabel.isHidden = false
            self.mainScreenView.loadingActivityIndicator.startAnimating()
        }
        
        networkService.loadHeroesData(limit: limit, offset: offset) { [weak self] result in
            switch result {
            case let .success(heroesWithThumbnails):
                if let heroesFromHeroesManager = self?.heroesManager.makeHeroesArray(fromHeroesNetworkData: heroesWithThumbnails, isRefreshingData: self?.isRefreshingData ?? false, isCutOffUnsuccessfulHeroesCard: self?.isCutOffUnsuccessfulHeroesCard ?? false) {
                    DispatchQueue.main.async {
                        self?.heroes = heroesFromHeroesManager
                        self?.mainScreenView.collectionView.reloadData()
                        self?.offset += self?.limit ?? 0
                    }
                }
                DispatchQueue.main.async {
                    self?.mainScreenView.loadingDataStatusLabel.isHidden = true
                    self?.mainScreenView.loadingActivityIndicator.stopAnimating()
                    self?.isDataLoading = false
                    self?.isRefreshingData = false
                }
                completion?()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension MainScreenViewController: NetworkServiceDelegate {
    func configureUIViewControllerWithoutNetworkConnection() {
        DispatchQueue.main.async {
            let failureAlertController = UIAlertController(title: "Attention!", message: "Error loading data from the network", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            failureAlertController.addAction(okAction)
            self.isDataLoading = false
            self.present(failureAlertController, animated: true) {
                self.mainScreenView.loadingDataStatusLabel.isHidden = true
                self.mainScreenView.loadingActivityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
