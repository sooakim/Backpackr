//
//  BPDetailViewController.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift

final class BPDetailViewController: BPViewController, View{
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: ReactorKit Lifecycle
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: BPDetailReactor){
        
    }
}
