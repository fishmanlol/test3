//
//  TYLabel.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYLabel: UILabel {
    
    private var ctFrame: CTFrame!
    private var clickableArray: [(Range<String.Index>, (String) -> Void)] = []
    private var clickableAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue]
    
    var attributes: [NSAttributedString.Key: Any] = [:]
    
    //public functions
    public func makeClickable(at range: Range<String.Index>, handler: @escaping (String) -> Void) {
        guard let attributedText = attributedText, let text = text else { return }
        clickableArray.append((range, handler))
        
        //attach attributes on clickable string
        let mutable = NSMutableAttributedString(attributedString: attributedText)
        let nsrange = (text as NSString).range(of: String(text[range]))
        mutable.addAttributes(clickableAttributes, range: nsrange)
        self.attributedText = mutable
        print(attributedText)
    }
    
    //overrides
    override var text: String? {
        get {
            return attributedText?.string
        }
        
        set {
            guard let newValue = newValue else { return }
            updateText(to: newValue)
        }
    }
    
    override var textColor: UIColor! {
        get {
            guard let color = attributes[NSAttributedString.Key.foregroundColor] as? UIColor else { return super.textColor }
            return color
        }
        
        set {
            attributes[NSAttributedString.Key.foregroundColor] = newValue
        }
    }
    
    override var font: UIFont! {
        get {
            guard let f = attributes[NSAttributedString.Key.font] as? UIFont else { return super.font }
            return f
        }
        
        set {
            attributes[NSAttributedString.Key.font] = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //self-owned
    var kern: CGFloat {
        get {
            guard let k = attributes[NSAttributedString.Key.kern] as? CGFloat else { return 0 }
            return k
        }
        
        set {
            attributes[NSAttributedString.Key.kern] = newValue
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let text = text else { return }

        context.translateBy(x: 0, y: bounds.height)
        context.scaleBy(x: 1, y: -1)

        let path = UIBezierPath(rect: bounds)
        
        let mutable = NSMutableAttributedString(string: text, attributes: attributes)
        for (range, _) in clickableArray {
            let nsrange = (text as NSString).range(of: String(text[range]))
            mutable.addAttributes(clickableAttributes , range: nsrange)
        }
        let cfAttributedString = mutable as CFMutableAttributedString
        
        let frameSetter = CTFramesetterCreateWithAttributedString(cfAttributedString)
        ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path.cgPath, nil)
        
        CTFrameDraw(ctFrame, context)
    }
    
    private func indexAtPoint(_ point: CGPoint) -> Int? {
        let flipped = CGPoint(x: point.x, y: bounds.height - point.y)
        let lines = CTFrameGetLines(ctFrame) as NSArray
        var origins = Array<CGPoint>(repeating: CGPoint.zero, count: lines.count)
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, lines.count), &origins)
        for i in 0..<lines.count {
            if (flipped.y > origins[i].y) {
                let line = lines.object(at: i) as! CTLine
                return CTLineGetStringIndexForPosition(line, flipped) as Int
            }
        }

        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let text = text else { return }
        let point = touch.location(in: self)
        if let index = self.indexAtPoint(point) {
            let stringIndex = text.index(text.startIndex, offsetBy: index)
            let clickableArrayCount = clickableArray.count
            for i in 0..<clickableArrayCount {
                let clickableRange = clickableArray[clickableArrayCount - i - 1].0
                let clickHandler = clickableArray[clickableArrayCount - i - 1].1
                if clickableRange.contains(stringIndex) {
                    let clickableString = String(text[clickableRange])
                    clickHandler(clickableString)
                    return
                }
            }
        } else {
            print("No index here")
        }
    }
    
    private func setup() {
        isUserInteractionEnabled = true
    }
    
    private func updateText(to text: String) {
        clickableArray.removeAll()
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
