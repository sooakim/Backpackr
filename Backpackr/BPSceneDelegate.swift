//
//  SceneDelegate.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class BPSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    // MARK: UISceneSession Lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let viewController = BPMainViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.reactor = BPMainReactor()
        let navigationController = BPMainNavigationController(rootViewController: viewController)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

