//
//  ObservableType+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 16/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType{
    func withPrevious(startWith first: E) -> Observable<(E, E)> {
        return scan((first, first)) { ($0.1, $1) }.skip(1)
    }
}
