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
        button.setTitle("Show Alert", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func showAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert", message: "This is a alert", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
            textField.autocorrectionType = .no
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let textField = alert.textFields?.first, let value = textField.text else { return }
            NSLog(value)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(submitAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

}

