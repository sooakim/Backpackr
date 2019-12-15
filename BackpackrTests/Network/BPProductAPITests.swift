//
//  BPProductAPITests.swift
//  BackpackrTests
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import XCTest
import Moya
import RxSwift
import RxBlocking
@testable import Backpackr

class BPProductAPITests: XCTestCase{
    private var productAPI: MoyaProvider<BPProductAPI>!
    
    override func setUp() {
        self.productAPI = MoyaProvider<BPProductAPI>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    override func tearDown() {
        self.productAPI = nil
    }
    
    func testProducts(){
        do{
            let products = try self.productAPI.rx.request(.products(page: 1))
                .decodeJson()
                .map{ (response: BPResponse<BPProduct>) in
                    response.body
                }
                .toBlocking()
                .single()
            
            XCTAssertFalse(products.count == 0)
        }catch{
            XCTFail(error.localizedDescription)
        } 
    }
    
    func testProduct(){
        let testId: UInt = 1
        
        do{
            let productDetail = try self.productAPI.rx.request(.product(id: testId))
                .decodeJson()
                .map{ (response: BPResponse<BPProductDetail>) in
                    response.body
                }
                .toBlocking()
                .single()
            
            XCTAssertFalse(productDetail.count == 0)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
}
