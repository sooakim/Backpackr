//
//  BPMainResponse.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import RxDataSources

/**
 {
   "id": 1,
   "thumbnail_520": "https://image.idus.com/image/files/4e47e2fa54e84fedbe56b610475adf0c_520.jpg",
   "title": "겨울에 아삭한여름복숭아먹기",
   "seller": "골든팜"
 }
 */
struct BPProduct: Decodable{
    let id: UInt
    let thumbnail: String
    let title: String
    let seller: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = values.decode(forKey: .id, default: 0)
        self.thumbnail = values.decode(forKey: .thumbnail, default: "")
        self.title = values.decode(forKey: .title, default: "")
        self.seller = values.decode(forKey: .seller, default: "")
    }
    
    enum CodingKeys: String, CodingKey{
        case id, title, seller
        case thumbnail = "thumbnail_520"
    }
}

extension BPProduct: Equatable{
    static func == (lhs: BPProduct, rhs: BPProduct) -> Bool{
        return lhs.id == rhs.id &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.title == rhs.title &&
            lhs.seller == rhs.seller
    }
}

extension BPProduct: IdentifiableType{
    var identity: UInt{
        return id
    }
}
