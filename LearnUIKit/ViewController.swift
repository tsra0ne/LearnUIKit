//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 21/02/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var hwLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World"
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .discord
        view.addSubview(hwLabel)
        
        hwLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}

