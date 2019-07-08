//
//  ViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var input: TYInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let input = TYNormalInput(frame: CGRect(x: 100, y: 100, width: 200, height: 100), hasSecureButton: true)
        input.labelText = "FIRST NAME"
        input.labelKern = 2
        input.labelColor = UIColor.blue
        
        input.text = "This is a test!"
        input.textKern = 2
        input.textColor = UIColor.red
        self.input = input
        view.addSubview(input)
    }
    
    
}

