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
        
        let button = TYButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.backgroundColor = UIColor.yellow
        button.setTitle("Hello", for: .normal)
        self.button = button
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        if button.isLoading {
            button.stopAnimating()
        } else {
            button.startAnimating()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        button.isEnabled = !button.isEnabled
    }
}

extension ViewController: TYInputDelegate {
    
}

