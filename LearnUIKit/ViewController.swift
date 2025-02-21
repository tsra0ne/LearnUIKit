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
        
        hwLabel.backgroundColor = .purple
        
        hwLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }

}

