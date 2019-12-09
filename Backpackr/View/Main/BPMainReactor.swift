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
        case initialLoad
        case loadMore
    }
    
    enum Mutation{
        case setProducts([BPProduct], nextPage: UInt)
        case appendProducts([BPProduct], nextPage: UInt)
        case setLoadingNextPage(Bool)
    }
    
    struct State {
        var products: [BPProduct] = []
        var nextPage: UInt = 1
        var isLoadingNextPage: Bool = false
    }
    
    let initialState: BPMainReactor.State = State()
    
    func mutate(action: BPMainReactor.Action) -> Observable<BPMainReactor.Mutation> {
        switch action{
        case .initialLoad:
            return getProducts()
                .takeUntil(self.action.filter{ $0 == .initialLoad })
                .map{ (products: [BPProduct], nextPage: UInt) in
                    Mutation.setProducts(products, nextPage: nextPage)
                }
        case .loadMore:
            guard !self.currentState.isLoadingNextPage else{
                return .empty()
            }
            return Observable.concat(
                .just(Mutation.setLoadingNextPage(true)),
                self.getProducts(inPage: currentState.nextPage)
                    .takeUntil(self.action.filter{ $0 == .initialLoad })
                    .map{ (products: [BPProduct], nextPage: UInt) in
                        Mutation.appendProducts(products, nextPage: nextPage)
                    }
            )
        }
    }
    
    func reduce(state: BPMainReactor.State, mutation: BPMainReactor.Mutation) -> BPMainReactor.State {
        switch mutation{
        case .setProducts(let products, let nextPage):
            var newState = state
            newState.products = products
            newState.nextPage = nextPage
            return newState
        case .appendProducts(let products, let nextPage):
            var newState = state
            newState.products.append(contentsOf: products)
            newState.nextPage = nextPage
            newState.isLoadingNextPage = false
            return newState
        case .setLoadingNextPage(let isLoadingNextPage):
            var newState = state
            newState.isLoadingNextPage = isLoadingNextPage
            return newState
        }
    }
    
    private lazy var productAPI: MoyaProvider<BPProductAPI> = {
        return MoyaProvider<BPProductAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }()
    
    private func getProducts(inPage page: UInt = 1) -> Observable<([BPProduct], UInt)>{
        return self.productAPI.rx.request(.products(page: page))
            .map{ (response: Response) in
                try JSONDecoder().decode(BPResponse<BPProduct>.self, from: response.data)
            }.map{ (response: BPResponse<BPProduct>) in
                (response.body, page + 1)
            }.asObservable()
            .catchErrorJustReturn(([], page))
    }
}
