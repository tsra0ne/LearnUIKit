//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        for color in [UIColor.red, UIColor.green, UIColor.blue] {
            let view = UIView()
            view.backgroundColor = color
            view.snp.makeConstraints { make in
                make.width.height.equalTo(100)
            }
            stackView.addArrangedSubview(view)
        }
    }

}

