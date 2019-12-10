//
//  UICollectionView+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 10/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    func deselectItems(exclusionAt: IndexPath, animated: Bool){
        self.indexPathsForSelectedItems?.filter{
            $0 != exclusionAt
        }.forEach{
            self.deselectItem(at: $0, animated: animated)
        }
    }
}
