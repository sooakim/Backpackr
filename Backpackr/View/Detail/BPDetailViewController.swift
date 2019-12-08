//
//  BPDetailViewController.swift
//  Backpackr
//
//  Created by Sooa Kim on 07/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift
import RxGesture
import KRWordWrapLabel

final class BPDetailViewController: BPViewController, ReactorKit.View{
    // MARK: UIViewController Lifecycle
    
    var productId: UInt = 0
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    private var onInitialLoad: PublishSubject<Void> = PublishSubject<Void>()
    
    private lazy var dismissView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.xdark.withAlphaComponent(0.16)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var dismissImageView: UIImageView = {
        return UIImageView(image: #imageLiteral(resourceName: "ic_close"))
    }()
    private lazy var thumbnailStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .horizontal
        return view
    }()
    private lazy var thumbnailScrollView: UIScrollView = {
        let view = UIScrollView()
        view.layer.cornerRadius = 26
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    private lazy var thumbnailView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var sellerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .darkSkyBlue
        view.font = UIFont.notoSansFont(ofSize: 12, weight: .black)
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.numberOfLines = 1
        return view
    }()
    private lazy var spaceView1: UIView = {
        return UIView()
    }()
    private lazy var titleLabel: KRWordWrapLabel = {
        let view = KRWordWrapLabel()
        view.textColor = .dark
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.sfProtextFont(ofSize: 40, weight: .black)
        view.numberOfLines = 0
        return view
    }()
    private lazy var spaceView2: UIView = {
        return UIView()
    }()
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    private lazy var spaceView3: UIView = {
        return UIView()
    }()
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .paleGreyTwo
        return view
    }()
    private lazy var spaceView4: UIView = {
        return UIView()
    }()
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .dark
        view.font = UIFont.notoSansFont(ofSize: 16, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    private lazy var spaceView5: UIView = {
        return UIView()
    }()
    private lazy var warningLabel: UILabel = {
        let view = UILabel()
        view.text = "warning".localized
        view.textColor = .coolGrey
        view.font = UIFont.notoSansFont(ofSize: 12, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    private lazy var warningView: UIView = {
        let view = UIView()
        view.backgroundColor = .paleGrey
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 122, right: 24)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    private lazy var rootStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        return view
    }()
    private lazy var rootScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInsetAdjustmentBehavior = .always
        view.isPagingEnabled = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    private lazy var purchaseButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .coralPink
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.titleLabel?.textColor = .white
        view.titleLabel?.font = UIFont.notoSansFont(ofSize: 18, weight: .black)
        view.setTitle("구매하기", for: .normal)
        return view
    }()
    private lazy var progressView: BPProgressView = {
        let view = BPProgressView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onInitialLoad.onNext(Void())
        
        self.dismissView.addSubview(dismissImageView)
        
        self.thumbnailScrollView.addSubview(thumbnailStackView)
        self.thumbnailView.addSubview(thumbnailScrollView)
        self.thumbnailView.addSubview(progressView)
        
        self.warningView.addSubview(warningLabel)
        
        self.contentStackView.addArrangedSubview(sellerLabel)
        self.contentStackView.addArrangedSubview(spaceView1)
        self.contentStackView.addArrangedSubview(titleLabel)
        self.contentStackView.addArrangedSubview(spaceView2)
        self.contentStackView.addArrangedSubview(priceLabel)
        self.contentStackView.addArrangedSubview(spaceView3)
        self.contentStackView.addArrangedSubview(lineView)
        self.contentStackView.addArrangedSubview(spaceView4)
        self.contentStackView.addArrangedSubview(descriptionLabel)
        self.contentStackView.addArrangedSubview(spaceView5)
        self.contentStackView.addArrangedSubview(warningView)
        self.contentView.addSubview(contentStackView)
        
        self.rootStackView.addArrangedSubview(thumbnailView)
        self.rootStackView.addArrangedSubview(contentView)
        self.rootScrollView.addSubview(rootStackView)
        
        self.view.addSubview(rootScrollView)
        self.view.addSubview(dismissView)
        self.view.addSubview(purchaseButton)
        
        
        self.progressView.snp.makeConstraints{ [unowned self] in
            $0.leading.equalTo(self.thumbnailView.snp.leading).inset(24)
            $0.bottom.equalTo(self.thumbnailView.snp.bottom).inset(24)
            $0.trailing.equalTo(self.thumbnailView.snp.trailing).inset(24)
            $0.height.equalTo(4)
        }
        self.purchaseButton.snp.makeConstraints{ [unowned self] in
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(24)
            $0.height.equalTo(52)
        }
        self.dismissImageView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.dismissView.snp.top).inset(13)
            $0.leading.equalTo(self.dismissView.snp.leading).inset(13)
            $0.bottom.equalTo(self.dismissView.snp.bottom).inset(13)
            $0.trailing.equalTo(self.dismissView.snp.trailing).inset(13)
        }
        self.dismissView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.width.equalTo(40)
            $0.width.equalTo(self.dismissView.snp.height)
        }
        self.thumbnailStackView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.thumbnailScrollView.snp.top)
            $0.leading.equalTo(self.thumbnailScrollView.snp.leading)
            $0.bottom.equalTo(self.thumbnailScrollView.snp.bottom)
            $0.trailing.equalTo(self.thumbnailScrollView.snp.trailing)
            $0.height.equalTo(self.thumbnailScrollView.snp.height)
        }
        self.thumbnailScrollView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.thumbnailView.snp.top)
            $0.leading.equalTo(self.thumbnailView.snp.leading)
            $0.bottom.equalTo(self.thumbnailView.snp.bottom)
            $0.trailing.equalTo(self.thumbnailView.snp.trailing)
        }
        self.thumbnailView.snp.makeConstraints{ [unowned self] in
            $0.width.equalTo(self.thumbnailView.snp.height)
        }
        self.spaceView1.snp.makeConstraints{
            $0.height.equalTo(16)
        }
        self.spaceView2.snp.makeConstraints{
            $0.height.equalTo(32)
        }
        self.spaceView3.snp.makeConstraints{
            $0.height.equalTo(32)
        }
        self.lineView.snp.makeConstraints{
            $0.height.equalTo(2)
        }
        self.spaceView4.snp.makeConstraints{
            $0.height.equalTo(24)
        }
        self.spaceView5.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        self.warningLabel.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.warningView.snp.top).inset(16)
            $0.leading.equalTo(self.warningView.snp.leading).inset(18)
            $0.bottom.equalTo(self.warningView.snp.bottom).inset(16)
            $0.trailing.equalTo(self.warningView.snp.trailing).inset(18)
        }
        self.contentStackView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.trailing.equalTo(self.contentView.snp.trailing)
        }
        self.rootStackView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.rootScrollView.snp.top)
            $0.leading.equalTo(self.rootScrollView.snp.leading)
            $0.bottom.equalTo(self.rootScrollView.snp.bottom)
            $0.trailing.equalTo(self.rootScrollView.snp.trailing)
            $0.width.equalTo(self.rootScrollView.snp.width)
        }
        self.rootScrollView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.view.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.bottom.equalTo(self.view.snp.bottom)
            $0.trailing.equalTo(self.view.snp.trailing)
        }
        
        self.dismissView.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else{ return }
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
        
        
        self.thumbnailScrollView.rx.didScroll.asObservable()
            .map{ [weak self] in
                guard let `self` = self else{ return 0 }
                return Float((self.thumbnailScrollView.contentOffset.x + self.thumbnailScrollView.bounds.width)
                    / self.thumbnailScrollView.contentSize.width)
        }
        .bind(to: self.progressView.rx.progress)
        .disposed(by: self.disposeBag)
    }
    
    // MARK: ReactorKit Lifecycle
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: BPDetailReactor){
        self.onInitialLoad.asObserver()
            .map{ [unowned self] in
                BPDetailReactor.Action.initialLoad(id: self.productId)
        }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map{ $0.product }
            .bind{ [weak self] (product: BPProductDetail) in
                guard let `self` = self else{ return }
                self.bind(product: product)
        }.disposed(by: self.disposeBag)
    }
    
    private func bind(product: BPProductDetail){
        self.thumbnailStackView.removeArrangedSubviews()
        product.thumbnails.map{ (thumbnail: String) -> UIImageView in
            let view = UIImageView()
            view.backgroundColor = .darkGray
            view.kf.setImage(with: URL(string: thumbnail)!)
            return view
        }.forEach{ (childView: UIImageView) in
            self.thumbnailStackView.addArrangedSubview(childView)
            childView.snp.makeConstraints{
                $0.height.equalTo(self.thumbnailStackView.snp.height)
                $0.height.equalTo(childView.snp.width)
            }
        }
        
        self.progressView.progress = 1 / Float(product.thumbnails.count)
        self.sellerLabel.text = product.seller
        self.titleLabel.text = product.title
        self.priceLabel.attributedText = priceAttributedString(
            discountRate: product.discountRate,
            cost: product.cost,
            discountCost: product.discountCost
        )
        self.descriptionLabel.text = product.description
    }
    
    private func priceAttributedString(discountRate: UInt, cost: String, discountCost: UInt) -> NSAttributedString{
        let attributedString = NSMutableAttributedString()
        
        //discountRate part, show only if greater than 0
        if(discountRate > 0){
            attributedString.append(NSAttributedString(
                string: "-\(discountRate)%",
                attributes: [
                    .font: UIFont.sfProtextFont(ofSize: 20, weight: .black),
                    .foregroundColor: UIColor.coralPink,
                ]
            ))
            attributedString.append(NSAttributedString(string: "  "))
        }
        
        //cost part
        attributedString.append(NSAttributedString(
            string: cost,
            attributes: [
                .font: UIFont.sfProtextFont(ofSize: 20, weight: .black),
                .foregroundColor: UIColor.dark
            ]
        ))
        if attributedString.mutableString.contains("unit_krw".localized){
            let range = attributedString.mutableString.range(of: "unit_krw".localized)
            attributedString.replaceCharacters(in: range, with: NSAttributedString(
                string: "unit_krw".localized,
                attributes: [
                    .font: UIFont.sdGothicNeoFont(ofSize: 20, weight: .extraBold),
                    .foregroundColor: UIColor.dark,
                ]
            ))
        }
        
        //discountCost part, show only if greater than 0
        if(discountCost > 0){
            attributedString.append(NSAttributedString(string: "  "))
            attributedString.append(NSAttributedString(
                string: String(format: "%d%@", discountCost, "unit_krw".localized),
                attributes: [
                    .font: UIFont.sdGothicNeoFont(ofSize: 20, weight: .extraBold),
                    .foregroundColor: UIColor.blueyGrey,
                    .strikethroughStyle: NSUnderlineStyle.thick.rawValue,
                ]
            ))
        }
        
        return attributedString
    }
}
