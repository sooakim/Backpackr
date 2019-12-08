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

class BPProductCollectionViewCell: BPCollectionViewCell<BPProduct>{
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.backgroundColor = .darkGray
        return view
    }()
    private lazy var emptyView: UIView = {
        return UIView()
    }()
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.textColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1)
        view.font = UIFont.notoSans(.black, size: 14)
        return view
    }()
    private lazy var sellerLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.lineBreakMode = .byTruncatingTail
        view.adjustsFontSizeToFitWidth = false
        view.textColor = UIColor(red: 171/255, green: 171/255, blue: 196/255, alpha: 1)
        view.font = UIFont.notoSans(.bold, size: 14)
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        return view
    }()
    
    override func setUp() {
        self.stackView.addArrangedSubview(thumbnailImageView)
        self.stackView.addArrangedSubview(emptyView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(sellerLabel)
        self.contentView.addSubview(stackView)
        
        self.thumbnailImageView.snp.makeConstraints{ [unowned self] in
            $0.width.equalTo(self.thumbnailImageView.snp.height)
        }
        self.emptyView.snp.makeConstraints{
            $0.height.equalTo(4)
        }
        self.stackView.snp.makeConstraints{ [unowned self] in
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.top.equalTo(self.contentView.snp.top)
            $0.trailing.equalTo(self.contentView.snp.trailing)
            $0.bottom.equalTo(self.contentView.snp.bottom)
        }
    }
    
    override func bind(model: BPProduct) {
        self.thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail)!)
        self.titleLabel.text = model.title
        self.sellerLabel.text = model.seller
    }
}
