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
    case products(page: UInt = 1)
    case product(id: UInt)
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
            return "/products/\(id)"
        }
    }
    
    var task: Task {
        switch self{
        case .products(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .product:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self{
        case .products:
            return self.data(from: "products")
        case .product:
            return self.data(from: "product")
        }
    }
}
