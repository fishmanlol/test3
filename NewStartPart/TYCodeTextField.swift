//
//  TYCodeTextField.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/9/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYCodeTextField: UITextField {
    
    private var kern: CGFloat = 0 {
        didSet {
            defaultTextAttributes[NSAttributedString.Key.kern] = kern
        }
    }
    
    var digits: Int = 6 {
        didSet {
            if digits < 1 { return }
        }
    }
    
    var underLineHeight: CGFloat = 1.2
    var underLineWidth: CGFloat = 24
    var underLineColor: UIColor = .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        self.
        self.font = UIFont(name: "Menlo-Regular", size: 17)
        self.backgroundColor = UIColor(white: 0.7, alpha: 1)
        self.delegate = self
        self.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        self.keyboardType = .phonePad
        
        if #available(iOS 12.0, *) {
            self.textContentType = .oneTimeCode
        }
    }
    
    private var defaultCharacterWidth: CGFloat {
        let attributedText = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.font: UIFont(name: "Menlo-Regular", size: 17)])
        return attributedText.size().width
    }
    
    override func draw(_ rect: CGRect) {
//        let portionWidth = ((underLineWidth - defaultCharacterWidth) < 0 ? 0 : (underLineWidth - defaultCharacterWidth)) * 0.5
        var gapWidth = (rect.width - CGFloat(digits) * underLineWidth) / CGFloat(digits - 1)
        gapWidth = gapWidth < 0 ? 0 : gapWidth
        
//        kern = 2 * portionWidth + gapWidth
        kern = underLineWidth + gapWidth - defaultCharacterWidth
//        print("kern: ----", kern)
        
        let path = UIBezierPath()
        
//        for i in 0..<digits {
//            let startPoint = CGPoint(x: rect.minX + CGFloat(i) * (gapWidth + underLineWidth), y: rect.maxY)
//            let endPoint = CGPoint(x: startPoint.x + underLineWidth, y: rect.maxY)
//
//            path.move(to: startPoint)
//            path.addLine(to: endPoint)
//            underLineColor.setStroke()
//            path.stroke()
//        }
        for i in 0..<digits {
            let startPoint = CGPoint(x: rect.minX + CGFloat(i) * (gapWidth + underLineWidth), y: rect.maxY)
            let endPoint = CGPoint(x: startPoint.x + underLineWidth, y: rect.maxY)
            
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            underLineColor.setStroke()
            path.stroke()
        }

    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let dx = (underLineWidth - defaultCharacterWidth) * 0.5
        return bounds.insetBy(dx: dx, dy: 0)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        let portionWidth = ((underLineWidth - defaultCharacterWidth) < 0 ? 0 : (underLineWidth - defaultCharacterWidth)) * 0.5
//        print("underLineWidth ", underLineWidth)
//        print("defaultCharacterWidth", defaultCharacterWidth)
//        print(portionWidth)
        let dx = (underLineWidth - defaultCharacterWidth) * 0.5
        return bounds.insetBy(dx:  dx, dy: 0)
    }
//
    @objc private func valueChanged(sender: UITextField) {
        let count = sender.text?.count ?? 0
        
        if count > digits - 1 {
            let _ = resignFirstResponder()
        }
    }
}

extension TYCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let char = string.cString(using: .utf8) { //allow backsapce
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        let nowCount = textField.text?.count ?? 0
        let newCount = string.count
        
        return nowCount + newCount > digits ? false : true
    }
}
