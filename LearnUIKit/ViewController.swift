//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let button = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "First VC"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.barTintColor = .systemGray6
        
        let menuButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.leftBarButtonItems = [menuButton, saveButton]
        
        let action1 = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
            print("Copy selected")
        }
        let action2 = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            print("Share selected")
        }
        let menu = UIMenu(title: "Options", children: [action1, action2])
        let menuCTA = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
        navigationItem.rightBarButtonItem = menuCTA
        
        view.addSubview(button)
        
        button.setTitle("Navigate", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func saveTapped() {
        print("Save button tapped")
    }

    @objc func menuTapped() {
        print("Menu button tapped")
    }
    
    @objc func buttonTapped() {
        guard let navigationController else { return }
        let secondVC = SecondViewController()
        navigationController.pushViewController(secondVC, animated: true)
    }

}

class SecondViewController: UIViewController {
    
    let button = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Second VC"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(button)
        
        button.setTitle("Navigate", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func buttonTapped() {
        let thirdVC = ThirdViewController()
        present(thirdVC, animated: true)
    }

}

class ThirdViewController: UIViewController {
    
    let button = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Third VC"
        
        view.addSubview(button)
        
        button.setTitle("Navigate", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func buttonTapped() {
        NSLog("Navigation Done...")
    }

}
