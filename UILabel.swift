//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 19/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        configureLabel()
        
        view.addSubview(label)
        
        configureLabelConstraints()
    }
    
    func configureLabel() {
        label.text = "Hello World"
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 44.0)
        label.shadowOffset = CGSize(width: 20, height: 20)
        label.shadowColor = .systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLabelConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

}

#Preview {
    ViewController()
}
