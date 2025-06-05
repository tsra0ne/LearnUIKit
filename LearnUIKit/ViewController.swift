//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let switchControl = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        switchControl.isOn = false
        switchControl.onTintColor = .systemGreen
        switchControl.thumbTintColor = .white
        switchControl.isEnabled = true
        switchControl.addTarget(self, action: #selector(switchPressed), for: .valueChanged)
        
        view.addSubview(switchControl)
        
        switchControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func switchPressed(_ sender: UISwitch) {
        NSLog("Switch is \(sender.isOn ? "on" : "off")")
    }

}

