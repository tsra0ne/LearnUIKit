//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var btn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
    }

    func setupUI() {
        configureButton()
        configureConstraints()
    }
    
    func configureButton() {
        view.backgroundColor = .white
        
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        config.image = UIImage(systemName: "checkmark.circle")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemGreen
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        btn.configuration = config
//        btn.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
        
        let action1 = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
            self.doSomething()
        }
        
        let action2 = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            self.doSomething()
        }
        
        let menu = UIMenu(title: "Options", children: [action1, action2])
        
        btn.menu = menu
        btn.showsMenuAsPrimaryAction = true
        
        view.addSubview(btn)
    }
    
    func configureConstraints() {
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func doSomething() {
        NSLog("Button Tapped...")
    }

}

