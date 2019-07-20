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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        HUD.show("Verifying...")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        HUD.hide()
    }
}

