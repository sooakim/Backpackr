//
//  Bool+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 09/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import RxDataSources

extension Bool: IdentifiableType{
    public var identity: Bool{
        return self
    }
}
