//
//  UITableView+Cells.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

// MARK: - Ease handling TableView cells registeration and dequeueing
extension UITableView {
    /// Cell Registeration
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    
    /// Cell Dequeueing
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
    }
}
