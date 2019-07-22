//
//  FinishViewController.swift
//  NewStartPart
//
//  Created by tongyi on 7/21/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class FinishViewController: StartBaseViewController {
    weak var imageView: UIImageView!
    weak var titleLabel: TYLabel!
    weak var descriptionLabel: TYLabel!
    
    private var flow: Flow!
    
    init(flow: Flow) {
        self.flow = flow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func nextButtonTapped(sender: TYButton) {
        switch flow! {
        case .forgotPassword(_):
            navigationController?.popToRootViewController(animated: true)
        case .registration(_):
            if let loginViewController = navigationController?.viewControllers.first {
                let viewController = ViewController()
                navigationController?.setViewControllers([loginViewController, viewController], animated: false)
            } else {
                navigationController?.popToRootViewController(animated: false)
            }
        }
    }
}

extension FinishViewController { //Helper functions
    private func setup() {
        backButton.isHidden = true
        nextButton.isEnabled = true
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
        self.imageView = imageView
        view.addSubview(imageView)
        
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize + 2)
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let descriptionLabel = TYLabel(frame: .zero)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.middleFontSize)
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        
        switch flow! {
        case .forgotPassword(_):
            titleLabel.text = "Success!"
            nextButton.setTitle("Back", for: .normal)
        case .registration(_):
            titleLabel.text = "Welcome!"
            descriptionLabel.text = "The doctor is one click away!"
            nextButton.setTitle("Home Page", for: .normal)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalTo(60)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
            } else {
                make.top.equalToSuperview().offset(120)
            }
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalTo(60)
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }
    }
}
