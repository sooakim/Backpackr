//
//  BPAppDelegate.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import UIKit

class BPAppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Dependency Injection
    let dependency: BPAppDependency
    
    //for system
    private override init(){
        self.dependency = BPAppDependency.resolve()
        super.init()
    }
    
    //for test
    init(dependency: BPAppDependency){
        self.dependency = dependency
    }
    
    // MARK: Variables
    
    var window: UIWindow?
    
    // MARK: UIAppDelegate Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *){
            //Do on BPSceneDelegate
        }else {
            self.window?.rootViewController = dependency.rootViewControllerFactory.create(payload: .init())
            self.window?.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

