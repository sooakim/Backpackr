//
//  BPMainReactor.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import Moya

final class BPMainReactor: Reactor{
    enum Action{
        case InitalLoad
        case LoadMore
    }
    
    enum Mutation{
        case setProducts([BPProduct])
    }
    
    struct State {
        var products: [BPProduct] = []
    }
    
    let initialState: BPMainReactor.State = State()
    
    func mutate(action: BPMainReactor.Action) -> Observable<BPMainReactor.Mutation> {
        switch action{
        case .InitalLoad:
            return getProducts()
                .map{ (products: [BPProduct]) in
                    Mutation.setProducts(products)
                }
        case .LoadMore:
            return getProducts()
                .map{ (products: [BPProduct]) in
                    Mutation.setProducts(products)
                }
        }
    }
    
    func reduce(state: BPMainReactor.State, mutation: BPMainReactor.Mutation) -> BPMainReactor.State {
        switch mutation{
        case .setProducts(let products):
            var newState = state
            newState.products = products
            return newState
        }
    }
    
    private lazy var productAPI: MoyaProvider<BPProductAPI> = {
        return MoyaProvider<BPProductAPI>()
    }()
    
    private func getProducts() -> Observable<[BPProduct]>{
        return self.productAPI.rx.request(.products)
            .map{ (response: Response) in
                try JSONDecoder().decode(BPResponse<BPProduct>.self, from: response.data)
            }.map{ (response: BPResponse<BPProduct>) in
                response.body
            }.asObservable()
    }
}
