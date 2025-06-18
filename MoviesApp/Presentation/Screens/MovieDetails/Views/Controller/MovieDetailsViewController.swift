//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet weak var heartButtonView: UIView!
    @IBOutlet weak var heartIcon: UIImageView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var containerCardView: UIView!
    @IBOutlet weak var bottomCordTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: DetailsHeaderSection!
    @IBOutlet weak var centerSection: CenterSectionMovieDetails!
    @IBOutlet weak var overViewSection: OverviewSection!
    @IBOutlet weak var companiesListView: ProductionCompaniesListView!
    
    // MARK: - Properties
    let viewModel: MovieDetailsViewModel
    var panRecognizer: UIPanGestureRecognizer?
    var initialConstraintConstant: CGFloat = 0
    var initialDragOffset: CGFloat = 0
    
    // MARK: - Initializer(s)
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupHeartButton()
        addCardPanGestureRecognizer()
        bindToViewModelObservables()
        viewModel.loadMovieDetails()
        adjustCardConstraint(isInMaxHeightMode: false, withAnimation: false)
        scrollView.delegate = self
    }
    
    // MARK: - Back Button handling
    private func setupBackButton() {
        backButtonImage.isUserInteractionEnabled = true
        backButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTapped(_:))))
    }
    
    @objc func backButtonTapped(_ gesture: UITapGestureRecognizer) {
        viewModel.popBack()
    }
    
    // MARK: - Heart Button handling
    private func setupHeartButton() {
        heartButtonView.isUserInteractionEnabled = true
        heartButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(heartButtonTapped(_:))))
    }
    
    @objc func heartButtonTapped(_ gesture: UITapGestureRecognizer) {
        heartIcon.tintColor = !viewModel.isFavorite ? .red : .black
        viewModel.updateFavoriteState()
    }
    
    // MARK: - Pan Gesture handling
    private func addCardPanGestureRecognizer() {
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        guard let panRecognizer else { return }
        containerCardView.addGestureRecognizer(panRecognizer)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: view).y
        switch gesture.state {
        case .began:
            initialConstraintConstant = bottomCordTopConstraint.constant
            
        case .changed:
            let newConstraintConstant = initialConstraintConstant + translationY
            if newConstraintConstant <= posterImage.frame.height - 16 && newConstraintConstant >= (view.safeAreaInsets.top + 24 + backButtonImage.frame.height) {
                bottomCordTopConstraint.constant = newConstraintConstant
            }
            
        case .ended:
            if translationY > 50 {
                adjustCardConstraint(isInMaxHeightMode: false)
            } else if translationY < -50 {
                adjustCardConstraint(isInMaxHeightMode: true)
            } else {
                bottomCordTopConstraint.constant = initialConstraintConstant
                UIView.animate(withDuration: 0.25) { [weak self] in
                    guard let self else { return }
                    view.layoutIfNeeded()
                }
            }
       
        default:
            break
        }
    }
    
    /// Adjust details card top constraint to show the details in one of 2 states either the full height or the collapsed state
    /// - Parameters:
    ///   - isInMaxHeightMode: Decides the state to match
    ///   - withAnimation: use animation or just jump into the required state instantly
    private func adjustCardConstraint(
        isInMaxHeightMode: Bool,
        withAnimation: Bool = true
    ) {
        scrollView.isScrollEnabled = isInMaxHeightMode
        panRecognizer?.isEnabled = !isInMaxHeightMode || (isInMaxHeightMode && scrollView.contentSize.height > containerCardView.frame.height)
        if isInMaxHeightMode {
            bottomCordTopConstraint.constant = view.safeAreaInsets.top + 8 + backButtonImage.frame.height + 16
        } else {
            bottomCordTopConstraint.constant = (UIScreen.main.bounds.width * 1.2) - 16
        }
        if withAnimation {
            UIView.animate(withDuration: 0.35) { [weak self] in
                guard let self else { return }
                view.layoutIfNeeded()
            }
        } else {
            view.layoutIfNeeded()
        }
    }
    
    // MARK: - ViewModel Observable(s)
    private func bindToViewModelObservables() {
        bindToLoadingObservable()
        bindToDataUpdateObservable()
        bindToErrorObservable()
    }
    
    // MARK: - Loading Observable
    private func bindToLoadingObservable() {
        viewModel.loadingObservable.bind { [weak self] isLoading in
            guard let self else { return }
            isLoading ? startLoadingIndicator() : stopLoadingIndicator()
            if isLoading {
                updateUIVisibility(isHidden: true)
            }
        }
    }
    
    /// Handle visibility of the UI based on the current state of the view
    private func updateUIVisibility(isHidden: Bool) {
        heartButtonView.isHidden = isHidden
        containerCardView.isHidden = isHidden
        posterImage.isHidden = isHidden
    }
    
    // MARK: - Data update Observable
    private func bindToDataUpdateObservable() {
        viewModel.didLoadMovieDetails.bind { [weak self] in
            guard let self else { return }
            updateUIVisibility(isHidden: false)
            setDataIntoViews()
        }
    }
    
    // MARK: - Setting loaded date into respective views
    private func setDataIntoViews() {
        addTopGradient()
        heartIcon.tintColor = viewModel.isFavorite ? .red : .black
        setupPosterImage()
        setupHeaderView()
        centerSection.setupSection(cellsData: viewModel.getCenterSectionArray())
        setupOverViewSeciton()
        companiesListView.setup(using: viewModel.movie?.productionCompanies ?? [])
    }
    
    /// Adding top gradient for visibility
    private func addTopGradient() {
        gradientView.addBackgroundGradient(colors: [UIColor.black.cgColor, UIColor.black.withAlphaComponent(0.0005).cgColor], direction: .vertical)
    }
    
    /// Setting poster image
    private func setupPosterImage() {
        posterImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        posterImage.sd_setImage(with: ImageURLCreator.createURL(for: viewModel.movie?.posterPath ?? ""))
    }
    
    /// Setting up header view
    private func setupHeaderView() {
        headerView.setupView(using: viewModel.getHeaderData()) { [weak self] in
            guard let self else { return }
            viewModel.presentMovieWebSite()
        }
    }
    
    /// Setting up overview section
    private func setupOverViewSeciton() {
        if let overView = viewModel.movie?.overview, !overView.isEmpty {
            overViewSection.setupOverview(overView)
        } else {
            overViewSection.isHidden = true
        }
    }
    
    // MARK: - Errors Observable
    private func bindToErrorObservable() {
        viewModel.errorObservable.bind { [weak self] error in
            guard let self else { return }
            updateUIVisibility(isHidden: true)
            addFullScreenErrorView { [weak self] in
                guard let self else { return }
                viewModel.loadMovieDetails()
            }
        }
    }
}

// MARK: - Scroll View Handling
extension MovieDetailsViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        initialDragOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking
            && scrollView.panGestureRecognizer.translation(in: view).y > 0
            && scrollView.contentOffset.y <= 0
            && initialDragOffset <= 0 {
            adjustCardConstraint(isInMaxHeightMode: false)
        }
    }
}
