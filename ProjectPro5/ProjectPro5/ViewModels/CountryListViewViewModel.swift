//
//  CountryListViewViewModel.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation
import UIKit

protocol CountryListViewViewModelDelegate: AnyObject {
    func didLoadInitialCountries()
    func didSelectCountry(_ country: Country)
}

final class CountryListViewViewModel: NSObject {
    
    public weak var delegate: CountryListViewViewModelDelegate?
    
    private var cellViewModel: [CountryTableViewCellViewModel] = []
    
    private var countries: [Country] = [] {
        didSet{
            for country in countries {
                let viewModel = CountryTableViewCellViewModel(countryName: country.name.common, countryImageURL: URL(string: country.flags.png))
                cellViewModel.append(viewModel)
            }
        }
    }
    
    func fetchCountries() {
        Service.shared.execute(.listCountryRequest, expecting: [Country].self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel
                self?.countries = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCountries()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CountryListViewViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.cellIdentifier, for: indexPath) as?  CountryTableViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModel[indexPath.row])
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        delegate?.didSelectCountry(country)
    }
    
    
    
}
