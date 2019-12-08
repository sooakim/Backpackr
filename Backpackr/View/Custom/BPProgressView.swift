//
//  BPProgressView.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BPProgressView: UIView{
    var outerColor: UIColor = UIColor.darkNavyBlue.withAlphaComponent(0.36){
        didSet{
            self.setNeedsDisplay()
        }
    }
    var innerColor: UIColor = UIColor.white{
        didSet{
            self.setNeedsDisplay()
        }
    }
    var progress: Float = 0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUp()
    }
    
    private func setUp(){
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else{ return }
        context.saveGState()
        context.setAllowsAntialiasing(true)
        
        //outer rounded box
        self.drawBox(context, fillWith: outerColor, in: rect)
        
        //inner rounded box
        var innerRect = rect
        innerRect.size.width = innerRect.maxX * CGFloat(min(max(progress, 0), 1))
        self.drawBox(context, fillWith: innerColor, in: innerRect)
        
        context.restoreGState()
    }
    
    private func drawBox(_ context: CGContext, fillWith color: UIColor, in rect: CGRect){
        let radius = rect.height / 2
        
        color.setFill()
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context.addArc(
            tangent1End: CGPoint(x: rect.minX, y: rect.minY),
            tangent2End: CGPoint(x: rect.midX, y: rect.minY),
            radius: radius
        )
        context.addArc(
            tangent1End: CGPoint(x: rect.maxX, y: rect.minY),
            tangent2End: CGPoint(x: rect.maxX, y: rect.midY),
            radius: radius
        )
        context.addArc(
            tangent1End: CGPoint(x: rect.maxX, y: rect.maxY),
            tangent2End: CGPoint(x: rect.midX, y: rect.maxY),
            radius: radius
        )
        context.addArc(
            tangent1End: CGPoint(x: rect.minX, y: rect.maxY),
            tangent2End: CGPoint(x: rect.minX, y: rect.midY),
            radius: radius
        )
        context.closePath()
        context.fillPath()
        
    }
}

extension Reactive where Base: BPProgressView {

    /// Bindable sink for `progress` property
    var progress: Binder<Float> {
        return Binder(self.base) { progressView, progress in
            progressView.progress = progress
        }
    }
}
