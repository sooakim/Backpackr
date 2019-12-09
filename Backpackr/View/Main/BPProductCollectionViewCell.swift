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

final class BPProductCollectionViewCell: BPCollectionViewCell<BPProduct>{
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .darkGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
        self.stackView.addArrangedSubview(thumbnailImageView)
        self.stackView.addArrangedSubview(spaceView1)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(sellerLabel)
        self.stackView.addArrangedSubview(spaceView2)
        self.contentView.addSubview(stackView)
        
        self.thumbnailImageView.snp.makeConstraints{ [unowned self] in
            $0.width.equalTo(self.thumbnailImageView.snp.height)
        }
        self.spaceView1.snp.makeConstraints{
            $0.height.equalTo(4)
        }
        self.spaceView2.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.stackView.snp.makeConstraints{ [unowned self] in
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.trailing.equalTo(self.contentView.snp.trailing)
        }
    }
    
    override func bind(model: BPProduct) {
        self.thumbnailImageView.kf.setImage(with: URL(string: model.thumbnail)!)
        self.titleLabel.text = model.title
        self.sellerLabel.text = model.seller
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
