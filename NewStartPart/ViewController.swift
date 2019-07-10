//
//  ViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    weak var input: TYInput!
    weak var textField: TYCodeTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        let input = TYNormalInput(frame: CGRect(x: 100, y: 100, width: 300, height: 60), type: .phoneNumber)
//
//        input.labelText = "FIRST NAME"
//
//        input.labelColor = UIColor(r: 79, g: 170, b: 248)
//        self.input = input
//        view.addSubview(input)
        let textField = TYCodeTextField(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
        self.textField = textField
        view.addSubview(textField)
    }
    
    
}

