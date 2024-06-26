//
//  AppDelegate.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import UIKit
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var monitor: NWPathMonitor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: RoverPage())
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: AppStyle.color(for: .gray302F2C)]
                
        let backImage = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        startNetworkMonitoring()
        return true
    }

//    internet kontrolu yaptigim fonksiyon- yoksa popup cikartiyor data yuklenmiyor
    func startNetworkMonitoring() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if !(path.status == .satisfied) {
                    let alertController = UIAlertController(title: Constants.AppStr.networkErrTitle, message: Constants.AppStr.networkErrMessage, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: Constants.AppStr.ok, style: .default))
                    if let viewController = self?.window?.rootViewController {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        monitor?.start(queue: queue)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        monitor?.cancel()
    }
}


