//
//  BPProductAPI.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import Moya

enum BPProductAPI{
    case products
    case product(id: Int)
}

extension BPProductAPI: TargetType{
    var method: Moya.Method{
        switch self{
        case .products, .product:
            return .get
        }
    }
    
    var path: String{
        switch self{
        case .products:
            return "/products"
        case .product(let id):
            return "/product/\(id)"
        }
    }
    
    var task: Task {
        switch self{
        case .products, .product:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self{
        case .products:
            return data(from: "Products")
        case .product:
            return data(from: "Product")
        }
    }
}
