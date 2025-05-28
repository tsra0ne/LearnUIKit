//
//  MainViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit

class MainViewController: UIViewController, CustomAlertDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let showAlertButton = UIButton(type: .system)
        showAlertButton.setTitle("Show Alert", for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        view.addSubview(showAlertButton)
        
        showAlertButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func showAlert() {
        let alertVC = CustomAlertViewController()
        alertVC.delegate = self
        present(alertVC, animated: true)
    }
    
    func alertDidConfirm() {
        debugPrint("User confirmed the alert")
    }
    
    func alertDidCancel() {
        debugPrint("User cancelled the alert")
    }

}
