//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        button.setTitle("Show Action Sheet", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func showActionSheet(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Options", message: "Choose an action", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Edit", style: .default)
        let action2 = UIAlertAction(title: "Delete", style: .destructive)
        let action3 = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        present(alertController, animated: true, completion: nil)
    }

}

