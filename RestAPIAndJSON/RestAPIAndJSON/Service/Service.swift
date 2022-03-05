//
//  Service.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import UIKit

class Service {
    static let shared = Service()
        
    func loadInfo(url : URL, completion : @escaping (Result<Data,Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept" : "aplication/json"]
        request.httpBody = nil
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else {return}
                completion(.success(data))
            }
            })
        .resume()
    }
}

