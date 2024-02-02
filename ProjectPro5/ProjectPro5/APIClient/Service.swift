//
//  Service.swift
//  ProjectPro5
//
//  Created by Chingiz on 02.02.24.
//

import Foundation

final class Service{
    
    static let shared = Service()
    
    private init() {}
    
    enum ServiceError: Error{
       case failedToCreateRequest
       case failedToGetData
    }
    
    public func execute<T: Codable>(_ request: Request, expecting type: T.Type, completions: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completions(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
            guard let data = data, error == nil else {
                completions(.failure(ServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completions(.success(result))
            } catch {
                completions(.failure(error))
            }
        }
        task.resume()
        
    }
    
    private func request(from request: Request) -> URLRequest?{
        guard let url = request.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
