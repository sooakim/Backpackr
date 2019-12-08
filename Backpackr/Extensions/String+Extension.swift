//
//  String+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 09/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation

extension String{
    var localized: String{
        return self.localizedString(for: self)
    }
    
    func localizedString(for key: String, with comment: String = "") -> String{
       return NSLocalizedString(key, comment: comment)
    }
}
