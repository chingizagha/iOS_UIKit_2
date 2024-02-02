//
//  CountryViewController.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import UIKit

class CountryViewController: UIViewController, CountryListViewDelegate {
    
    private let countryListView = CountryListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .systemBackground
        setUpView()
    }
    
    func setUpView(){
        countryListView.delegate = self
        view.addSubview(countryListView)
        NSLayoutConstraint.activate([
            countryListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            countryListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            countryListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    func countryView(_ countryListView: CountryListView, didSelectCountry country: Country) {
        let viewModel = CountryDetailViewViewModel(country: country)
        let detailVC = CountryDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.navigationController?.pushViewController(detailVC, animated: true)
    }
        
    
    
 


}
