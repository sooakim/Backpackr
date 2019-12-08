//
//  BPMainViewController.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

final class BPMainViewController: BPViewController, View{
    // MARK: UIViewController Lifecycle
    
    private static let CELL_PRODUCT = "cellProduct"
    private var onInitialLoad: PublishSubject<Void> = PublishSubject()
    
    private lazy var titleImageView: UIImageView = {
          return UIImageView(image: #imageLiteral(resourceName: "ic_store"))
      }()
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 7
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.register(BPProductCollectionViewCell.self, forCellWithReuseIdentifier: BPMainViewController.CELL_PRODUCT)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.onInitialLoad.onNext(Void())
        
        self.navigationItem.titleView = titleImageView
        self.view.addSubview(collectionView)
        
        self.collectionView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.view.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.bottom.equalTo(self.view.snp.bottom)
            $0.trailing.equalTo(self.view.snp.trailing)
        }
        
        self.collectionView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: ReactorKit Lifecycle
    
    internal var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: BPMainReactor){
        self.onInitialLoad.asObserver()
            .map{
                BPMainReactor.Action.initialLoad
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self, weak reactor] (indexPath: IndexPath) in
                guard let `self` = self else { return }
                self.collectionView.deselectItem(at: indexPath, animated: false)
                
                guard let product = reactor?.currentState.products[indexPath.row] else{ return }
                let detailViewController = BPDetailViewController()
                detailViewController.reactor = BPDetailReactor()
                detailViewController.productId = product.id
                detailViewController.modalPresentationStyle = .fullScreen
                self.present(detailViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map{ $0.products }
            .bind(to: self.collectionView.rx.items(cellIdentifier: BPMainViewController.CELL_PRODUCT)) {
                (_, model: BPProduct, cell: UICollectionViewCell) in
                (cell as? BPProductCollectionViewCell)?.bind(model: model)
            }.disposed(by: self.disposeBag)
    }
}

extension BPMainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.bounds.width
            - flowLayout.sectionInset.left - flowLayout.sectionInset.right
            - flowLayout.minimumInteritemSpacing
        return CGSize(
            width: width / 2,
            height: width / 2 + 4 + 40 + 20
        )
    }
}
