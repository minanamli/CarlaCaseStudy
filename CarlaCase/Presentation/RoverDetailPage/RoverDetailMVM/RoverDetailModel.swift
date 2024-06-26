//
//  RoverDetailModel.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import Foundation

struct RoverDetailResponse: Codable {
    let latestPhotos: [LatestPhoto]

    enum CodingKeys: String, CodingKey {
        case latestPhotos = "latest_photos"
    }
}

struct LatestPhoto: Codable {
    let id: Int
    let sol: Int
    let camera: CameraDetail
    let imgSrc: String
    let earthDate: String
    let rover: RoverDetail

    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct CameraDetail: Codable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}

struct RoverDetail: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [CameraSummary]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

struct CameraSummary: Codable {
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
