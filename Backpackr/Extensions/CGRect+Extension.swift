//
//  CGRect+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 11/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension CGRect{
    //center of Rect
    var center: CGRect{
        //return rect with center origin
        get{
            return CGRect(
                origin: CGPoint(
                    x: self.width / 2 + self.origin.x,
                    y: self.height / 2 + self.origin.y
                ),
                size: self.size
            )
        }
        //set rect to center origin
        set(newValue){
            self.origin = CGPoint(
                x: newValue.origin.x - self.width / 2,
                y: newValue.origin.y - self.height / 2
            )
        }
    }
}
