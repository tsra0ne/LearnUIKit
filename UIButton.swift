//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 19/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureButton()
        view.addSubview(button)
        configureConstraints()
    }
    
    func configureButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
//        button.setTitle("Tap Me", for: .normal)
//        button.titleLabel?.text = "Tap Me"
//        button.titleLabel?.textColor = .white
        if #available(iOS 15, *) {
            button.configuration?.title = "Tap Me"
            button.configuration = .filled()
            button.configuration?.cornerStyle = .capsule
            button.configuration?.baseForegroundColor = .white
            button.configuration?.baseBackgroundColor = .systemRed
            button.configuration?.image = UIImage(systemName: "arrow.2.circlepath.circle")
            button.configuration?.imagePadding = 5
            button.configuration?.imagePlacement = .leading
            button.configurationUpdateHandler = { configuration in
                self.button.configuration?.title = "This is button title set programmatically"
            }
        }

    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonTapped() {
        if button.configuration?.baseBackgroundColor == .systemRed {
            button.configuration?.baseBackgroundColor = .systemBlue
            button.configuration?.baseForegroundColor = .systemTeal
        } else {
            button.configuration?.baseBackgroundColor = .systemRed
        }
    }
    
}

#Preview {
    ViewController()
}
