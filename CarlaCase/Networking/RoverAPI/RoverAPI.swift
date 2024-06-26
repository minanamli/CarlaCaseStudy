//
//  RoverAPI.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation
import Alamofire

class RoverAPI{
    
    static func getRovers(completion: @escaping (Result<RoverResponse, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: "rovers", method: .get) { (result: Result<RoverResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getRoverDetail(rovername: String, completion: @escaping (Result<RoverDetailResponse, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: "rovers/" + rovername + "/latest_photos", method: .get) { (result: Result<RoverDetailResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
