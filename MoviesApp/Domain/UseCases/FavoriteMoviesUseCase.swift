//
//  FavoriteMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 18/06/2025.
//

import Foundation

class FavoriteMoviesUseCase {
    // MARK: - Properties
    private let fileName = "favoriteMovies.plist"
    
    // MARK: - Saving Favorite Movies to an external file
    func saveMoviesList(_ moviesIds: [Int]) {
        guard let filePath = getFilePathURL() else { return }
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        let data = try? encoder.encode(moviesIds)
        try? data?.write(to: filePath)
    }
    
    // MARK: - Load favorite movies from file
    func getFavoriteMovies() -> [Int] {
        guard let filePath = getFilePathURL(),
              FileManager.default.fileExists(atPath: filePath.path)
        else { return [] }
        let url = URL(fileURLWithPath: filePath.path)
        guard let favListData = try? Data(contentsOf: url) else { return [] }
        guard let moviesIDsArray = try? PropertyListDecoder().decode(
            [Int].self,
            from: favListData
        ) else { return [] }
        return moviesIDsArray
    }
    
    /// Get the url of the file where we saved the ids of the favorite movies
    private func getFilePathURL() -> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)
            if let documents = paths.first, let documentsURL = NSURL(string: "file://\(documents)") {
                return documentsURL.appendingPathComponent(fileName)
        }
        return nil
    }
}
