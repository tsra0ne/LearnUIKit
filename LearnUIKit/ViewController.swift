//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let stepper = UIStepper()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.stepValue = 10
        stepper.autorepeat = true
        stepper.wraps = true
        stepper.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
        view.addSubview(stepper)
        stepper.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func valueChanged(_ sender: UIStepper) {
        NSLog("Value: \(sender.value)")
    }

}

