//
//  BPMainNavigationController.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import Pure

final class BPMainNavigationController: BPNavigationController, FactoryModule{
    // MARK: Dependency Injection
    struct Dependency{
        let mainViewControllerFactory: BPMainViewController.Factory
    }
    
    struct Payload{
        
    }
    
    init(dependency: Dependency, payload: Payload){
        super.init(rootViewController: dependency.mainViewControllerFactory.create(payload: .init()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.layer.shadowColor = UIColor.darkBlueGrey.cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: .zero, height: 2)
        self.navigationBar.layer.shadowRadius = 4
        self.navigationBar.layer.shadowOpacity = 0.12
        self.navigationBar.layer.masksToBounds = false
    
        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
    }
}
