//
//  BPProductDetailResponse.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation

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
struct BPProductDetailResponse: Decodable{
    let id: UInt
    let thumbnail: String
    let thumbnails: [String]
    let title: String
    let seller: String
    let costs: String
    let discountCost: UInt
    let discountRate: UInt
    let description: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = values.decode(forKey: .id, default: 0)
        self.thumbnail = values.decode(forKey: .thumbnail, default: "")
        self.thumbnails = values.decodeStringArray(forKey: .thumbnails)
        self.title = values.decode(forKey: .title, default: "")
        self.seller = values.decode(forKey: .seller, default: "")
        self.costs = values.decode(forKey: .costs, default: "")
        self.discountCost = values.decode(forKey: .discountCost, default: 0)
        self.discountRate = values.decode(forKey: .discountRate, default: 0)
        self.description = values.decode(forKey: .description, default: "")
    }
    
    enum CodingKeys: String, CodingKey{
        case id, title,
            seller, costs,
            discountCost, discountRate,
            description
        case thumbnail = "thumbnail_720"
        case thumbnails = "thumbnail_list_320"
    }
}
