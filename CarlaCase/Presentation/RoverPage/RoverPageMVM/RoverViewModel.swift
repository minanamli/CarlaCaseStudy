//
//  RoverViewModel.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation

class RoverViewModel{
    
    var roversArr: [Rover] = []
    var roverDetail: [LatestPhoto] = []
    
    func getRovers(completion: @escaping (Bool, Error?) -> Void) {
        RoverAPI.getRovers(completion: { result in
            switch result {
            case .success(let product):
                self.roversArr = product.rovers
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        })
    }
    
    func getRoverDetail(roverName: String, completion: @escaping (Bool, Error?) -> Void) {
        RoverAPI.getRoverDetail(rovername: roverName,completion: { result in
            switch result {
            case .success(let product):
                self.roverDetail = product.latestPhotos
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        })
    }
    
}
