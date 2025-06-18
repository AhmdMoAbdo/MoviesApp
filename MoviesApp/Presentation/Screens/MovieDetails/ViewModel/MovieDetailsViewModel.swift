//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import Foundation

class MovieDetailsViewModel {
    // MARK: - Properties
    private let movieID: Int
    var isFavorite: Bool = false
    var movie: Movie?
    private let router: MovieDetailsRouter
    private let detailsUseCase: MovieDetailsUseCase
    private weak var favStateDelegate: MovieFavoriteStateUpdable?
    
    // MARK: - Observable(s)
    var didLoadMovieDetails = Observable<Void>()
    var loadingObservable = Observable<Bool>()
    var errorObservable = Observable<NetworkErrors>()
    
    // MARK: - Initializer(s)
    init(
        movieID: Int,
        isFavorite: Bool,
        router: MovieDetailsRouter,
        detailsUseCase: MovieDetailsUseCase,
        favStateDelegate: MovieFavoriteStateUpdable?
    ) {
        self.movieID = movieID
        self.isFavorite = isFavorite
        self.router = router
        self.detailsUseCase = detailsUseCase
        self.favStateDelegate = favStateDelegate
    }
    
    // MARK: - Load Movie Details
    func loadMovieDetails() {
        loadingObservable.onNext(true)
        detailsUseCase.getMovieDetails(movieId: movieID) { [weak self] result in
            guard let self else { return }
            loadingObservable.onNext(false)
            switch result {
            case let .success(movie):
                self.movie = movie
                didLoadMovieDetails.onNext(())
                
            case let .failure(error):
                errorObservable.onNext(error)
            }
        }
    }
    
    // MARK: - Header Data
    func getHeaderData() -> DetailsHeaderSectionModel {
        return DetailsHeaderSectionModel(
            title: movie?.title ?? "",
            genres: movie?.genres?.map { $0.name ?? "" }.joined(separator: ", ") ?? "",
            watchURL: movie?.homepage,
            rating: movie?.voteAverage ?? 0,
            voteCount: movie?.voteCount ?? 0
        )
    }
    
    // MARK: - Center View Data Array
    func getCenterSectionArray() -> [CenterSectionCellData] {
        var centerData: [CenterSectionCellData] = []
        centerData.append(
            CenterSectionCellData(
                headerText: "Language",
                detailsText: movie?.spokenLanguages?.first?.englishName ?? "",
                alignment: .leading
            )
        )
        if let durationData = getDurationSectionCellData() {
            centerData.append(durationData)
        }
        if let releaseDateData = getFormattedReleaseDate() {
            centerData.append(releaseDateData)
        }
        return centerData
    }
    
    /// Getting the movie time if available
    func getDurationSectionCellData() -> CenterSectionCellData? {
        guard let runtime = movie?.runtime else { return nil }
        let hours = Int(runtime / 60)
        let minutes = runtime - (hours * 60)
        return CenterSectionCellData(
            headerText: "Duration",
            detailsText: "\(hours)h : \(minutes)m",
            alignment: .center
        )
    }
    
    /// Getting the formatted release date if available
    func getFormattedReleaseDate() -> CenterSectionCellData? {
        guard let releaseDate = movie?.releaseDate else {
            return nil
        }
        let releaseDateArray = releaseDate.split(separator: "-")
        let day = releaseDateArray.last ?? ""
        let year = releaseDateArray.first ?? ""
        let month = Int(releaseDateArray[safe: 1] ?? "1") ?? 1
        let monthName = DateFormatter().shortMonthSymbols[month - 1]
        return CenterSectionCellData(
            headerText: "Release Date",
            detailsText: "\(day) \(monthName) \(year)",
            alignment: .trailing
        )
    }
    
    // MARK: - Update movie favorite state and passing that update to the home screen
    func updateFavoriteState() {
        isFavorite.toggle()
        favStateDelegate?.updateFavoriteState(for: movieID, isFavorite: isFavorite)
    }
    
    // MARK: - Present Webview containing movie page
    func presentMovieWebSite() {
        guard let url = URL(string: movie?.homepage ?? "") else { return }
        router.navigateTo(.movieWebsite(url))
    }
    
    // MARK: - Pop View Controller
    func popBack() {
        router.navigateTo(.popBack)
    }
}
