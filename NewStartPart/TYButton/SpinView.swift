//
//  SpinView.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/15/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class SpinView: UIView {
    private(set) var isAnimating = false
    
    private lazy var endAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = frequency * 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        
        return animation
    }()
    
    private lazy var startAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = frequency * 0.5
        animation.duration = frequency * 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        return animation
    }()
    
    private lazy var spinAnimation: CAAnimationGroup = {
        let group = CAAnimationGroup()
        group.fillMode = kCAFillModeForwards
        group.duration = frequency
        group.repeatCount = Float.infinity
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.animations = [startAnimation, endAnimation]
        return group
    }()
    
    private lazy var spinLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        let w = bounds.width
        let h = bounds.height
        let path = UIBezierPath(arcCenter: CGPoint(x: w * 0.5, y: h * 0.5), radius: min(w * 0.5, h * 0.5), startAngle: CGFloat(-Double.pi * 0.5), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }()
    
    var frequency: Double = 1.35
    var lineWidth: CGFloat = 2
    var lineColor: UIColor = UIColor.red {
        didSet {
            spinLayer.strokeColor = lineColor.cgColor
        }
    }
    
    init(spinViewStyle: SpinViewStyle = .medium) {
        super.init(frame: CGRect(x: 0, y: 0, width: spinViewStyle.rawValue, height: spinViewStyle.rawValue))
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startAnimating() {
        if isAnimating { return }
        self.isHidden = false
        spinLayer.add(spinAnimation, forKey: "spin")
        isAnimating = true
    }
    
    func stopAnimating() {
        if !isAnimating { return }
        
        spinLayer.removeAnimation(forKey: "spin")
        self.isHidden = true
        isAnimating = false
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
    
    enum  SpinViewStyle: CGFloat {
        case small = 20
        case medium = 26
        case large = 32
    }
    
}
