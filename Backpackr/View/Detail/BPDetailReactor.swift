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
import Pure

final class BPDetailReactor: Reactor, FactoryModule{
    // MARK: Dependency Injection
    struct Dependency{
        let productAPI: MoyaProvider<BPProductAPI>
    }
    
    struct Payload{
        
    }
    
    init(dependency: BPDetailReactor.Dependency, payload: BPDetailReactor.Payload) {
        self.productAPI = dependency.productAPI
    }
    
    // MARK: Reactor
    
    enum Action{
        case initialLoad(id: UInt)
    }
    
    enum Mutation{
        case setProduct(BPProductDetail)
    }
    
    struct State{
        var product: BPProductDetail
    }
    
    let initialState: BPDetailReactor.State = State(
        product: BPProductDetail()
    )
    let productAPI: MoyaProvider<BPProductAPI>
    
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


