//
//  NetworkManager.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://mars-photos.herokuapp.com/api/v1/"
    
    func request<T: Decodable>(endpoint: String, method: HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = baseURL + endpoint
        AF.request(url, method: method, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
}
