//
//  PrimitiveSequence+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 11/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response{
    func decodeJson<T: Decodable>() -> Single<BPResponse<T>>{
        return flatMap{ (response: Element) in
            switch response.statusCode {
            case 200..<300:
                let decodedResponse = try JSONDecoder().decode(BPResponse<T>.self, from: response.data)
                switch decodedResponse.statusCode{
                case .success:
                    return .just(decodedResponse)
                default:
                    throw MoyaError.statusCode(response)
                }
            default:
                throw MoyaError.statusCode(response)
            }
        }
    }
}
