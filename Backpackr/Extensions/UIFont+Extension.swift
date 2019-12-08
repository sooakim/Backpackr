//
//  UIFont+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    enum NotoSansType: String{
        case black = "-Black"
        case bold = "-Bold"
    }
    
    static func notoSans(_ type: NotoSansType, size: CGFloat) -> UIFont{
        return UIFont(name: "NotoSansKR\(type.rawValue)", size: size)!
    }
}
