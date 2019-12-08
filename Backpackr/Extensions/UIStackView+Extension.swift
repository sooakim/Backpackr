//
//  UIStackView+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView{
    func removeArrangedSubviews(){
        self.subviews.forEach{ (subview: UIView) in
            self.removeArrangedSubview(subview)
        }
    }
}
