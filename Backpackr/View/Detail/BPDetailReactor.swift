//
//  BPDetailReactor.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import Moya

final class BPDetailReactor: Reactor{
    enum Action{
        case initialLoad(id: UInt)
    }
    
    enum Mutation{
        case setProduct(BPProductDetail)
    }
    
    struct State{
        var product: BPProductDetail
    }
    
    var initialState: BPDetailReactor.State = State(
        product: BPProductDetail()
    )
    
    func mutate(action: BPDetailReactor.Action) -> Observable<BPDetailReactor.Mutation> {
        switch action{
        case .initialLoad(let id):
            return getProduct(id: id)
                .map{ (product: BPProductDetail) in
                    Mutation.setProduct(product)
                }
        }
    }
    
    func reduce(state: BPDetailReactor.State, mutation: BPDetailReactor.Mutation) -> BPDetailReactor.State {
        switch mutation{
        case .setProduct(let product):
            var newState = state
            newState.product = product
            return newState
        }
    }
    
    private lazy var productAPI: MoyaProvider<BPProductAPI> = {
        return MoyaProvider<BPProductAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }()
     
    private func getProduct(id: UInt) -> Observable<BPProductDetail>{
        return self.productAPI.rx.request(.product(id: id))
            .decodeJson()
            .map{ (response: BPResponse<BPProductDetail>) in
                response.body.first!
            }
            .catchErrorJustReturn(BPProductDetail())
            .asObservable()
    }
}


