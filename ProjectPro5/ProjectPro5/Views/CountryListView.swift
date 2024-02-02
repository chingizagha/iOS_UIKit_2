//
//  CountryListView.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import UIKit

protocol CountryListViewDelegate: AnyObject {
    func countryView(_ countryListView: CountryListView, didSelectCountry country: Country)
}

class CountryListView: UIView {
    
    public weak var delegate: CountryListViewDelegate?
    
    private let viewModel = CountryListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isHidden = true
        tableView.alpha = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.cellIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        addSubview(tableView)
        
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCountries()
        setUpTableView()
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func setUpTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
    }
}

extension CountryListView: CountryListViewViewModelDelegate {
    
    func didLoadInitialCountries() {
        self.spinner.stopAnimating()
        self.tableView.isHidden = false
        tableView.reloadData()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.alpha = 1
        })
    }
    
    func didSelectCountry(_ country: Country) {
        delegate?.countryView(self, didSelectCountry: country)
    }
    
    
}
