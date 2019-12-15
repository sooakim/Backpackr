//
//  TargetType+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import Moya

extension TargetType{
    var baseURL: URL{
        return URL(string: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String)!
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType{
        return .successCodes
    }
    
    func data(from name: String, withType type: String = "json") -> Data{
        guard
            let url = Bundle.main.url(forResource: name, withExtension: type),
            let data = try? Data(contentsOf: url) else{
            return "".data(using: .utf8)!
        }
        return data
    }
}
