//
//  BPMainViewController.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift

final class BPMainViewController: BPCollectionViewController, View{
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
    }
    
    // MARK: ReactorKit Lifecycle
    
    func bind(reactor: BPMainReactor){
        
    }
}
