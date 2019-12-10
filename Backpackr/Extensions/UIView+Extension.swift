//
//  UIView+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
   //return frame with safeArea
   var safeAreaFrame: CGRect{
       let frame = self.frame
       return CGRect(
           origin: CGPoint(
               x: frame.origin.x + safeAreaInsets.left,
               y: frame.origin.y + safeAreaInsets.top
           ),
           size: CGSize(
               width: frame.width - safeAreaInsets.left - safeAreaInsets.right,
               height: frame.height - safeAreaInsets.top - safeAreaInsets.bottom
           )
       )
   }
}
