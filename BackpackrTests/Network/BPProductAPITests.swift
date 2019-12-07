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
@testable import Backpackr

class BPProductAPITests: XCTestCase{
    private var productAPI: MoyaProvider<BPProductAPI>!
    
    override func setUp() {
        self.productAPI = MoyaProvider<BPProductAPI>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    func testProducts(){
        _ = self.productAPI.rx.request(.products)
            .map{ (response: Response) in
                try JSONDecoder().decode(BPResponse<BPProduct>.self, from: response.data)
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (response: BPResponse<BPProduct>) in
                XCTAssertTrue(response.body.count != 0)
            }, onError: { (error: Error) in
                XCTAssertThrowsError(error)
            })
    }
    
    func testProduct(){
        let testId = 1
        _ = self.productAPI.rx.request(.product(id: testId))
            .map{ (response: Response) in
                try JSONDecoder().decode(BPResponse<BPProductDetail>.self, from: response.data)
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (response: BPResponse<BPProductDetail>) in
                XCTAssertTrue(response.body.count != 0)
            }, onError: { (error: Error) in
                XCTAssertThrowsError(error)
            })
    }
}
