//
//  BPCollectionReusableView.swift
//  Backpackr
//
//  Created by Sooa Kim on 09/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

class BPCollectionResuableView: UICollectionReusableView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    func setUp(){
        
    }
}
