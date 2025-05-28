//
//  CustomAlertViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

protocol CustomAlertDelegate: AnyObject {
    func alertDidConfirm()
    func alertDidCancel()
}

class CustomAlertViewController: UIViewController {
    
    weak var delegate: CustomAlertDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        view.addSubviews(confirmButton, cancelButton)
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmButton.snp.bottom).offset(20)
        }
    }
    
    @objc private func confirmTapped() {
        delegate?.alertDidConfirm()
        dismiss(animated: true)
    }
    
    @objc private func cancelTapped() {
        delegate?.alertDidCancel()
        dismiss(animated: true)
    }
}
