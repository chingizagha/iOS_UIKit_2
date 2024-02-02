//
//  CountryDetailViewViewModel.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation

final class CountryDetailViewViewModel {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    public var title: String{
        country.name.common.uppercased()
    }
}
