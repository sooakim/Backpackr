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

final class BPMainReactor: Reactor{
    enum Action{
        
    }
    
    enum Mutation{
        
    }
    
    struct State {
        var products: [BPProduct] = []
    }
    
    let initialState: BPMainReactor.State = State()
    
    func mutate(action: BPMainReactor.Action) -> Observable<BPMainReactor.Mutation> {
        
    }
    
    func reduce(state: BPMainReactor.State, mutation: BPMainReactor.Mutation) -> BPMainReactor.State {
        
    }
}
