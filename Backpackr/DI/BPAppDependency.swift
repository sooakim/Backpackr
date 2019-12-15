//
//  BPAppDependency.swift
//  Backpackr
//
//  Created by Sooa Kim on 14/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import Moya
import UIKit
import Pure

struct BPAppDependency{
    let rootViewControllerFactory: BPMainNavigationController.Factory
}

extension BPAppDependency{
    static func resolve() -> BPAppDependency{
        #if DEBUG
        let moyaPlugins = [NetworkLoggerPlugin(verbose: true)]
        #else
        let moyaPlugins = []
        #endif
        let productAPI = MoyaProvider<BPProductAPI>(plugins: moyaPlugins)
        
        let detailViewControllerFactory = BPDetailViewController.Factory(dependency: .init(
            detailReactorFactory: BPDetailReactor.Factory(dependency: .init(
                productAPI: productAPI
            ))
        ))
        let productCellConfigurator = BPProductCollectionViewCell.Configurator(dependency: .init())
        let loadingViewConfigurator = BPLoadingReuseableView.Configurator(dependency: .init())
        let mainViewControllerFactory = BPMainViewController.Factory(dependency: .init(
            mainReactorFactory: BPMainReactor.Factory(dependency: .init(
                productAPI: productAPI
            )),
            detailViewControllerFactory: detailViewControllerFactory,
            productCellConfigurator: productCellConfigurator,
            loadingViewConfigurator: loadingViewConfigurator
        ))
        let mainNavigationControllerFactory = BPMainNavigationController.Factory(dependency: .init(
            mainViewControllerFactory: mainViewControllerFactory
        ))
        
        return .init(
            rootViewControllerFactory: mainNavigationControllerFactory
        )
    }
}
