//
//  ViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class ViewController: StartBaseViewController {
    
    weak var input: TYInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = TYInput(frame: CGRect(x: 100, y: 100, width: 200, height: 60))
        input.labelText = "FIRST NAME"
        self.input = input
        view.addSubview(input)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

