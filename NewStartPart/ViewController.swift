//
//  ViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var button: TYButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let button = TYButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        button.setTitle("Test", for: .normal)
        self.button = button
        view.addSubview(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        
    }
    
}

extension ViewController: TYInputDelegate {
    
}

