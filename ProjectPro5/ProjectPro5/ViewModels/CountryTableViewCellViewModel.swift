//
//  CountryTableViewCellViewModel.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation

final class CountryTableViewCellViewModel {
    public let countryName: String
    public let countryImageURL: URL?
    
    init(countryName: String, countryImageURL: URL?) {
        self.countryName = countryName
        self.countryImageURL = countryImageURL
    }
    
    public func fetchImage(completions: @escaping (Result<Data, Error>) -> Void) {
        guard let url = countryImageURL else {
            completions(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completions(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completions(.success(data))
        }
        task.resume()
    }
}
