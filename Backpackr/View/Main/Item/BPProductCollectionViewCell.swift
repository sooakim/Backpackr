//
//  BPProductCollectionViewCell.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import Pure

final class BPProductCollectionViewCell: BPCollectionViewCell, ConfiguratorModule{
    // MARK: Dependency Injection
    struct Dependency{
        
    }
    
    struct Payload{
        let product: BPProduct
    }
    
    func configure(dependency: BPProductCollectionViewCell.Dependency, payload: BPProductCollectionViewCell.Payload) {
        self.product = payload.product
    }
    
    // MARK: Variables
    
    var product: BPProduct?{
        didSet{
            if let thumbnail = product?.thumbnail, let url = URL(string: thumbnail){
                self.thumbnailImageView.kf.setImage(with: url)
            }else{
                self.thumbnailImageView.image = nil
            }
            self.titleLabel.text = product?.title ?? ""
            self.sellerLabel.text = product?.seller ?? ""
        }
    }
    
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 14
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private lazy var thumbnailView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var spaceView1: UIView = {
        return UIView()
    }()
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.textColor = .dark
        view.font = UIFont.notoSansFont(ofSize: 14, weight: .black)
        return view
    }()
    private lazy var sellerLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.textColor = .blueyGrey
        view.font = UIFont.notoSansFont(ofSize: 14, weight: .bold)
        return view
    }()
    private lazy var spaceView2: UIView = {
        return UIView()
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    override func setUp() {
        self.thumbnailView.addSubview(thumbnailImageView)
        
        self.stackView.addArrangedSubview(thumbnailView)
        self.stackView.addArrangedSubview(spaceView1)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(sellerLabel)
        self.stackView.addArrangedSubview(spaceView2)
        self.contentView.addSubview(stackView)
        
        self.thumbnailImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        self.thumbnailView.snp.makeConstraints{ [unowned self] in
            $0.width.equalTo(self.thumbnailView.snp.height)
        }
        self.spaceView1.snp.makeConstraints{
            $0.height.equalTo(4)
        }
        self.spaceView2.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    static func size(width: CGFloat, model: BPProduct) -> CGSize{
        return CGSize(
            width: width,
            height: width
                + 4
                + ceil(UIFont.notoSansFont(ofSize: 14, weight: .black).lineHeight) * 2
                + ceil(UIFont.notoSansFont(ofSize: 14, weight: .bold).lineHeight)
        )
    }
}

extension BPProductCollectionViewCell: SharedElementTransition{
    func sharedElement() -> UIView? {
        return self.thumbnailImageView
    }
}
