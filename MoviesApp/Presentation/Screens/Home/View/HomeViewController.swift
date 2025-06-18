//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet weak var cellTypeSwitchImage: UIImageView!
    @IBOutlet weak var homeMoviesCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    private var cellType: HomeCellTypes = .grid
    
    // MARK: - Initializer(s)
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindToViewModelObservables()
        viewModel.getHomeMovies()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupCellTypeSwitch()
        setupCollectionView()
    }
    
    // MARK: - Cell type switch button
    private func setupCellTypeSwitch() {
        cellTypeSwitchImage.image = cellType.getAppropriateButtonImage()
        cellTypeSwitchImage.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(updateCellType)
            )
        )
    }
    
    /// Switch view Button Action
    @objc private func updateCellType() {
        let visibleCenterPoint = CGPoint(
            x: homeMoviesCollectionView.bounds.width / 2,
            y: homeMoviesCollectionView.contentOffset.y + homeMoviesCollectionView.bounds.height / 2
        )
        let targetIndexPath = homeMoviesCollectionView.indexPathForItem(at: visibleCenterPoint)
        switch cellType {
        case .grid:
            cellType = .banner

        case .banner:
            cellType = .grid
        }
        cellTypeSwitchImage.image = cellType.getAppropriateButtonImage()
        homeMoviesCollectionView.reloadData()
        homeMoviesCollectionView.scrollToItem(
            at: targetIndexPath ?? IndexPath(row: 0, section: 0),
            at: .centeredVertically,
            animated: false
        )
    }
    
    // MARK: - Collection View Setup
    private func setupCollectionView() {
        setupCollectionViewDelegates()
        setupCollectionViewCells()
    }
    
    /// Collection view delegate + data source
    private func setupCollectionViewDelegates() {
        homeMoviesCollectionView.dataSource = self
        homeMoviesCollectionView.delegate = self
    }
    
    /// Collection view cells
    private func setupCollectionViewCells() {
        homeMoviesCollectionView.register(HomeGridCollectionViewCell.self)
        homeMoviesCollectionView.register(HomeBannerCollectionViewCell.self)
    }
    
    // MARK: - ViewModel Observable(s)
    private func bindToViewModelObservables() {
        bindToLoadingObservable()
        bindToDataUpdateObservable()
        bindToErrorObservable()
        bindToFavoriteStateObservable()
    }
    
    /// Loading Observable
    private func bindToLoadingObservable() {
        viewModel.loadingObservable.bind { [weak self] isLoading in
            guard let self else { return }
            if isLoading && viewModel.homeMovies.isEmpty {
                startLoadingIndicator()
                cellTypeSwitchImage.isHidden = true
            } else {
                stopLoadingIndicator()
            }
        }
    }
    
    /// Data update Observable
    private func bindToDataUpdateObservable() {
        viewModel.didUpdateHomeMovies.bind { [weak self] in
            guard let self else { return }
            cellTypeSwitchImage.isHidden = false
            homeMoviesCollectionView.reloadData()
            removeFullScreenErrorView()
        }
    }
    
    /// Errors Observable
    private func bindToErrorObservable() {
        viewModel.errorObservable.bind { [weak self] error in
            guard let self else { return }
            cellTypeSwitchImage.isHidden = true
            if viewModel.homeMovies.isEmpty {
                addFullScreenErrorView { [weak self] in
                    guard let self else { return }
                    viewModel.getHomeMovies()
                }
            }
        }
    }
    
    /// Updating the favorite state observable
    private func bindToFavoriteStateObservable() {
        viewModel.favoriteStateObservable.bind { [weak self] (updatedItemIndex, isfavorite) in
            guard let self else { return }
            let cell = homeMoviesCollectionView.cellForItem(at: IndexPath(row: updatedItemIndex, section: 0)) as? HomeCellConfigurable
            cell?.updateFavoriteState(isfavorite)
        }
    }
}

// MARK: - Collection View Delegates
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.homeMovies.count
    }
    
    // MARK: - Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: HomeCellConfigurable?
        switch cellType {
        case .grid:
            cell = collectionView.dequeueReusableCell(HomeGridCollectionViewCell.self, for: indexPath)
            
        case .banner:
            cell = collectionView.dequeueReusableCell(HomeBannerCollectionViewCell.self, for: indexPath)
        }
        guard let cell else { return UICollectionViewCell() }
        cell.setupCell(
            with: viewModel.homeMovies[indexPath.row],
            isFavorite: viewModel.isFavorite(index: indexPath.row)
        ) { [weak self] isFavorite in
            guard let self else { return }
            viewModel.heartButtonTapped(index: indexPath.row, isFavorite: isFavorite)
        }
        return cell
    }
    
    // MARK: - Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToMovieDetails(index: indexPath.row)
    }
    
    // MARK: - Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.homeMovies.count - 1 {
            viewModel.getHomeMovies()
        }
    }
    
    // MARK: - Horizontal spcing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // MARK: - vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // MARK: - Section Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 8, bottom: 16, right: 8)
    }
    
    // MARK: - Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellType.getCellSize()
    }
}
