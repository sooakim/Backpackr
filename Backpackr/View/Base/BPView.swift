//
//  BPView.swift
//  Backpackr
//
//  Created by Sooa Kim on 14/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

class BPView: UIView{
    var interceptEvent: Bool = true
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.interceptEvent
    }
}
