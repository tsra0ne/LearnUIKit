//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let colorWell = UIColorWell()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        colorWell.selectedColor = .red
        colorWell.supportsAlpha = true
        colorWell.title = "Select Background Color"
        colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        
        view.addSubview(colorWell)
        colorWell.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func colorChanged(_ sender: UIColorWell) {
        view.backgroundColor = sender.selectedColor
    }

}

