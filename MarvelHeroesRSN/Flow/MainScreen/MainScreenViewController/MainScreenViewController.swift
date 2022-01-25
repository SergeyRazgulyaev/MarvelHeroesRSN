//
//  MainScreenViewController.swift
//  MarvelHeroesRSN
//
//  Created by Sergey Razgulyaev on 11.10.2021.
//

import UIKit

class MainScreenViewController: UIViewController, Alertable {
    //MARK: - UI properties
    private(set) lazy var mainScreenView: MainScreenView = {
        return MainScreenView()
    }()
    
    //MARK: - Properties
    private let cellIdentifier: String = "MainScreenCollectionViewCell"
    
    //MARK: - Properties for interaction with CollectionView
    private(set) lazy var dataProvider = MainScreenDataProvider(
		owningViewController: self,
		cellIdentifier: cellIdentifier
	)
    
    //MARK: - Properties for interaction with Network
    private let networkService: NetworkServiceProtocol
    private let limit: Int = 50
    private var offset: Int = 0
    private(set) var isDataLoading: Bool = false
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
			self.refreshControl.endRefreshing()
		} else {
			self.refreshControl.beginRefreshing()
			isRefreshingData = true
			loadHeroesDataFromNetWork() { [weak self] in
				DispatchQueue.main.async {
					self?.refreshControl.endRefreshing()
				}
			}
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
        mainScreenView.collectionView.delegate = dataProvider
        mainScreenView.collectionView.dataSource = dataProvider
        mainScreenView.collectionView.prefetchDataSource = dataProvider
        mainScreenView.collectionView.register(MainScreenCollectionViewCell.self,
                                               forCellWithReuseIdentifier: cellIdentifier)
        mainScreenView.collectionView.refreshControl = refreshControl
    }
}

//MARK: - Interaction with Network
extension MainScreenViewController {
    func loadHeroesDataFromNetWorkIfNeeded() {
        if dataProvider.heroesManager.getAllHeroesFromStorage().isEmpty {
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
                self?.dataProvider.heroesManager.fillHeroesStorage(withDataFromNetwork: heroesWithThumbnails,
                                                     isRefreshingData: self?.isRefreshingData ?? false,
                                                     isCutOffUnsuccessfulHeroesCard: self?.isCutOffUnsuccessfulHeroesCard ?? false)
                if let heroesFromHeroesManager = self?.dataProvider.heroesManager.getAllHeroesFromStorage() {
                    DispatchQueue.main.async {
                        self?.dataProvider.fillHeroes(fromArray: heroesFromHeroesManager)
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
