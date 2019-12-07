//
//  BPResponse.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation

/**
 {
   "statusCode": 200,
   "body": [
     ....
     ....
    ]
 }
 */
struct BPResponse<Body: Decodable>: Decodable{
    let statusCode: StatusCode
    let body: [Body]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.statusCode = values.decode(forKey: .statusCode, default: .notFound)
        self.body = values.decodeArray(forKey: .body)
    }
    
    enum CodingKeys: String, CodingKey{
        case statusCode, body
    }
    
    enum StatusCode: UInt, Decodable{
        case success = 200
        case badRequest = 400
        case notFound = 404
        case serverError = 500
        
        var isSuccess: Bool{
            return (200 <= self.rawValue && self.rawValue < 300)
        }
    }
}
