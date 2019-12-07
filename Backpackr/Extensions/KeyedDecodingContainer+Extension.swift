//
//  KeyedDecodingContainer+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer{
    func decode<T: Decodable>(forKey key: KeyedDecodingContainer.Key, `default`: T) -> T{
        return (try? decode(T.self, forKey: key)) ?? `default`
    }
    
    func decodeArray<T: Decodable>(forKey key: KeyedDecodingContainer.Key, `default`: [T] = []) -> [T]{
        return (try? decode([T].self, forKey: key)) ?? `default`
    }
    
    func decodeStringArray(forKey key: KeyedDecodingContainer.Key, separatedBy separator: String = "#") -> [String]{
        return self.decode(forKey: key, default: "").components(separatedBy: separator)
    }
}
