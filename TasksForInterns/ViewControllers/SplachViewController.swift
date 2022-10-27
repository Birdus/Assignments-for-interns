//
//  SplashViewController.swift
//  Tets Table
//
//  Created by Даниил Гетманцев on 09.06.2022.
//

import UIKit

class SplachViewController: UIViewController {
    
    // MARK: - Privates Ui
    private lazy var lblGreeting: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = UIColor.black
        lbl.font = lbl.font.withSize(30)
        lbl.text = "Добро пожаловать!"
        return lbl
    }()
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Privates func
    
    private func configureUI() {
        view.backgroundColor = .white
        self.view.addSubview(lblGreeting)
        
        let csCenterXLblGreeting = NSLayoutConstraint(item: lblGreeting,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1.0,
                                                  constant: 10)
        
        let csCenterYLblGreeting = NSLayoutConstraint(item: lblGreeting,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        self.view.addConstraints([csCenterXLblGreeting,csCenterYLblGreeting])
    }
}
