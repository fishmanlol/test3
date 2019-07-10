//
//  TYTextField.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYTextField: UITextField {
    
    private var bottomLineLayer: CALayer!
    
    //Bottom line
    var bottomLineHeight: CGFloat = 2.4 {
        didSet {
//            updateBottomLineHeight(to: bottomLineHeight)
            setNeedsDisplay()
        }
    }
    
    var bottomLineColor: UIColor = UIColor(r: 207, g: 212, b: 217) {
        didSet {
//            updateBottomLineColor(to: bottomLineColor)
            setNeedsDisplay()
        }
    }
    
    var kern: CGFloat = 0 {
        didSet {
            defaultTextAttributes[NSAttributedString.Key.kern] = kern
        }
    }
    
    override func draw(_ rect: CGRect) {
        let startPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = bottomLineHeight
        bottomLineColor.setStroke()
        path.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
