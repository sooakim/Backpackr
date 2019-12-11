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
    
    private static let IDENTIFIER_CELL_PRODUCT = "cellProduct"
    private static let IDENTIFIER_VIEW_LOADING = "viewLoading"
    private static let LOAD_MORE_DISTANCE = 20
    private var onInitialLoad: PublishSubject<Void> = PublishSubject()
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<Bool, BPProduct>>!
    
    private lazy var titleImageView: UIImageView = {
        return UIImageView(image: #imageLiteral(resourceName: "ic_store"))
    }()
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 7
        layout.headerReferenceSize = .zero
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.register(BPProductCollectionViewCell.self, forCellWithReuseIdentifier: BPMainViewController.IDENTIFIER_CELL_PRODUCT)
        view.register(
            BPLoadingReuseableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: BPMainViewController.IDENTIFIER_VIEW_LOADING
        )
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
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
        
        if #available(iOS 13, *){
            NotificationCenter.default.rx.notification(UIScene.willEnterForegroundNotification)
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else{ return }
                    self.startLoadingAnim()
                })
                .disposed(by: self.disposeBag)
            NotificationCenter.default.rx.notification(UIScene.didEnterBackgroundNotification)
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else{ return }
                    self.stopLoadingAnim()
                })
                .disposed(by: self.disposeBag)
        }else{
            NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else{ return }
                    self.startLoadingAnim()
                })
                .disposed(by: self.disposeBag)
            NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else{ return }
                    self.stopLoadingAnim()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startLoadingAnim()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopLoadingAnim()
    }
    
    private func startLoadingAnim(){
        self.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).forEach{
            ($0 as? BPLoadingReuseableView)?.startAnim()
        }
    }
    
    private func stopLoadingAnim(){
        self.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).forEach{
            ($0 as? BPLoadingReuseableView)?.stopAnim()
        }
    }
    
    // MARK: ReactorKit Lifecycle
    
    internal var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: BPMainReactor){
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<Bool, BPProduct>> (
            configureCell: {
                (_, collectionView: UICollectionView, indexPath: IndexPath, model: BPProduct) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BPMainViewController.IDENTIFIER_CELL_PRODUCT,
                    for: indexPath
                )
                (cell as? BPProductCollectionViewCell)?.bind(model: model)
                return cell
            },
            configureSupplementaryView: {
                (_, collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView in
                switch kind{
                case UICollectionView.elementKindSectionFooter:
                    return collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: BPMainViewController.IDENTIFIER_VIEW_LOADING,
                        for: indexPath
                    )
                default:
                    return UICollectionReusableView()
                }
            }
        )
        
        self.onInitialLoad.asObserver()
            .map{
                BPMainReactor.Action.initialLoad
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.collectionView.rx.willDisplayCell
            .filter{ [weak self] (cell: UICollectionViewCell, indexPath: IndexPath) in
                guard let `self` = self else{ return false }
                return indexPath.row
                    == (self.collectionView.numberOfItems(inSection: 0) - BPMainViewController.LOAD_MORE_DISTANCE)
        }
        .map{ _ in
            BPMainReactor.Action.loadMore
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.collectionView.rx.willDisplaySupplementaryView
            .filter{ (_, elementKind: String, _) in
                elementKind == UICollectionView.elementKindSectionFooter
            }.subscribe(onNext: { (supplementaryView: UICollectionReusableView, _, _) in
                (supplementaryView as? BPLoadingReuseableView)?.startAnim()
            }).disposed(by: self.disposeBag)
        
        self.collectionView.rx.didEndDisplayingSupplementaryView
            .filter{ (_, elementKind: String, _) in
                elementKind == UICollectionView.elementKindSectionFooter
            }.subscribe(onNext: { (supplementaryView: UICollectionReusableView, _, _) in
                (supplementaryView as? BPLoadingReuseableView)?.stopAnim()
            }).disposed(by: self.disposeBag)
        
        self.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self, weak reactor] (indexPath: IndexPath) in
                guard let `self` = self else { return }
                self.collectionView.deselectItems(exclusionAt: indexPath, animated: false)
                
                guard let product = reactor?.currentState.products[indexPath.row] else{ return }
                let detailViewController = BPDetailViewController()
                detailViewController.reactor = BPDetailReactor()
                detailViewController.productId = product.id
                detailViewController.modalPresentationStyle = .fullScreen
                detailViewController.transitioningDelegate = self
                self.present(detailViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map{ ($0.isLoadingNextPage, $0.products) }
            .map{ (model: Bool, items: [BPProduct]) in
                [AnimatableSectionModel(model: model, items: items)]
            }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
}

extension BPMainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = self.dataSource?[indexPath] else{
            return .zero
        }
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.bounds.width
            - flowLayout.sectionInset.left - flowLayout.sectionInset.right
            - flowLayout.minimumInteritemSpacing
        return BPProductCollectionViewCell.size(width: width / 2, model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let isLoading = self.dataSource?[section].model else{
            return .zero
        }
        if isLoading{
            let width = collectionView.bounds.width
            return BPLoadingReuseableView.size(width: width)
        }else{
            return .zero
        }
    }
}

extension BPMainViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BPDetailPresentAnimationController()
    }
    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        <#code#>
//    }
}

extension BPMainViewController: SharedElementTransition{
    func sharedElement() -> UIView? {
        guard
            let selectedIndexPath = self.collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = self.collectionView.cellForItem(at: selectedIndexPath) as? SharedElementTransition else{
            return nil
        }
        return selectedCell.sharedElement()
    }
}
