//
//  BPProductDetailResponse.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import RxDataSources

/**
 {
   "id": 250,
   "thumbnail_720": "https://image.idus.com/image/files/0b9ca2fae287417b95c87fe59e01f31b_720.jpg",
   "thumbnail_list_320": "https://image.idus.com/image/files/0b9ca2fae287417b95c87fe59e01f31b_320.jpg#https://image.idus.com/image/files/fa2e0876ad6b4f468eb11f7e1a16adda_320.jpg .....",
   "title": "[밀호밀] 원 스트랩 백 S사이즈",
   "seller": "milhomil",
   "cost": "20,000원",
   "discount_cost": null,
   "discount_rate": null,
   "description": "\n\n[밀호밀] 원 스트랩 백\n\nmaterial : 코튼 100％\n\ncolor : 베이지, 블랙, 네이비, 카멜\n\n✔️ 내부에 포켓이 생겼습니다😉\n ....."
 }
 */
struct BPProductDetail: Decodable{
    let id: UInt
    let thumbnail: String
    let thumbnails: [String]
    let title: String
    let seller: String
    let cost: String
    let discountCost: String?
    let discountRate: String?
    let description: String
    
    init(){
        self.id = 0
        self.thumbnail = ""
        self.thumbnails = []
        self.title = ""
        self.seller = ""
        self.cost = ""
        self.discountCost = nil
        self.discountRate = nil
        self.description = ""
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = values.decode(forKey: .id, default: 0)
        self.thumbnail = values.decode(forKey: .thumbnail, default: "")
        self.thumbnails = values.decodeStringArray(forKey: .thumbnails)
        self.title = values.decode(forKey: .title, default: "")
        self.seller = values.decode(forKey: .seller, default: "")
        self.cost = values.decode(forKey: .cost, default: "")
        self.discountCost = values.decode(forKey: .discountCost)
        self.discountRate = values.decode(forKey: .discountRate)
        self.description = values.decode(forKey: .description, default: "")
    }
    
    enum CodingKeys: String, CodingKey{
        case id, title,
            seller, cost,
            description
        case discountCost = "discount_cost"
        case discountRate = "discount_rate"
        case thumbnail = "thumbnail_720"
        case thumbnails = "thumbnail_list_320"
    }
}

extension BPProductDetail: Equatable{
    static func == (lhs: BPProductDetail, rhs: BPProductDetail) -> Bool{
        return lhs.id == rhs.id &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.thumbnails == rhs.thumbnails &&
            lhs.title == rhs.title &&
            lhs.seller == rhs.seller &&
            lhs.cost == rhs.cost &&
            lhs.discountCost == rhs.discountCost &&
            lhs.discountRate == rhs.discountRate &&
            lhs.description == rhs.description
    }
}

extension BPProductDetail: IdentifiableType{
    var identity: UInt{
        return id
    }
}
