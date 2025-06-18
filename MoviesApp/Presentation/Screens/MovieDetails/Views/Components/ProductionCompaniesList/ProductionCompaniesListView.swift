//
//  ProductionCompaniesListView.swift
//  MoviesApp
//
//  Created by Ahmed Abdo on 17/06/2025.
//

import UIKit

class ProductionCompaniesListView: UIView {
    // MARK: - Outlet(s)
    @IBOutlet weak var companiesTableView: SelfSizedTableView!
    
    // MARK: - Properties
    private var companiesList: [ProductionCompanies] = []
    
    // MARK: - Initializer(s)
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadNibFromFile()
        setupTableView()
    }
    
    // MARK: - Setting up table view
    private func setupTableView() {
        companiesTableView.registerCell(ProductionCompaniesCell.self)
        companiesTableView.dataSource = self
        companiesTableView.delegate = self
    }
    
    // MARK: - Setting up list view
    func setup(using companiesList: [ProductionCompanies]) {
        self.companiesList = companiesList
        companiesTableView.reloadData()
    }
}

// MARK: - Table view delegates
extension ProductionCompaniesListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ProductionCompaniesCell.self)
        else { return UITableViewCell() }
        cell.setupCell(with: companiesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
