//
//  BPLoadingReuseableView.swift
//  Backpackr
//
//  Created by Sooa Kim on 09/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

final class BPLoadingReuseableView: BPCollectionResuableView{
    
    private let KEY_ANIM_ROTATING = "rotatingAnim"
    
    private lazy var indicatorImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "ic_loading_indicator"))
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var rotatingAnim: CAAnimationGroup = {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.fromValue = 0
        anim.toValue = Double.pi * 2 * 2
        anim.duration = 1.5
        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        anim.isRemovedOnCompletion = false
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [anim]
        animGroup.duration = 2.0
        animGroup.repeatCount = .infinity
        return animGroup
    }()
    
    override func setUp() {
        self.contentView.addSubview(indicatorImageView)
        self.addSubview(contentView)
        
        self.indicatorImageView.snp.makeConstraints{ [unowned self] in
            $0.top.equalToSuperview().inset(42)
            $0.bottom.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(20)
            $0.width.equalTo(self.indicatorImageView.snp.height)
        }
        self.contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func startAnim(){
        if self.indicatorImageView.layer.animation(forKey: KEY_ANIM_ROTATING) == nil{
            self.indicatorImageView.layer.add(rotatingAnim, forKey: KEY_ANIM_ROTATING)
        }
    }
    
    func stopAnim(){
        if self.indicatorImageView.layer.animation(forKey: KEY_ANIM_ROTATING) != nil{
            self.indicatorImageView.layer.removeAnimation(forKey: KEY_ANIM_ROTATING)
        }
    }
    
    static func size(width: CGFloat) -> CGSize{
        return CGSize(
            width: width,
            height: 42 + 20 + 34
        )
    }
}
