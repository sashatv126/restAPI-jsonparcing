//
//  LoadData.swift
//  RestAPIAndJSON
//
//  Created by Владимир on 05.03.2022.
//

import Foundation

class LoadData {
    static let shared = LoadData()
    
    private init () {}
    
    func FilmsInfo(url : URL, responce : @escaping (Films?, Error?) -> Void) {
        Service.shared.loadInfo(url: url, completion: {result in
            switch result {
            case .success(let data):
                do {
                    let info = try JSONDecoder().decode(Films.self, from: data)
                    responce(info,nil)
                } catch let jsonError {
                    print(jsonError)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil,error)
            }
        })
    }
}
