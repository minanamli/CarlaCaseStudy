//
//  Constants.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation

struct Constants {
    
    struct ServiceError {
        static let internalServerError = "Lütfen internet bağlantınızı kontrol ediniz."
    }
    
    struct AppStr {
        static let networkErrTitle = "Bağlantı Hatası"
        static let networkErrMessage = "İnternet bağlantınızı kontrol ediniz."
        static let ok = "Tamam"
        static let error = "Hata"
        static let undefinedError = "Bilinmeyen hata"
        static let dataErrTitle = "Veriler Yüklenmedi"
        static let dataErrDesc = "Daha sonra tekrar deneyin."
        static let chooseRover = "Choose a Rover to Explore"
        static let landingDate = "Landing Date:"
        static let launchDate = "Launch Date:"
        static let active = "Active"
        static let deactive = "Deactive"
        static let deactiveErrTitle = "Kamera Aktif Değil"
        static let deactiveErrDesc = "Daha sonra tekrar deneyin."
        static let cameraNum = "Number of Cameras:"
        static let photonum = "Number of Photos:"
    }
    
    struct AppIcons {
        static let arrow = "arrow"
    }
    
}
