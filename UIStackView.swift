//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 19/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    let colors: [UIColor] = [
        .systemRed, .systemOrange, .systemTeal
    ]
    
    var stack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureStacks()
        view.addSubview(stack)
        configureColorViews()
        configureConstraints()
    }
    
    func configureColorViews() {
        for color in colors {
            let colorView = UIView()
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = 10
            stack.addArrangedSubview(colorView)
        }
    }
    
    func configureStacks() {
        stack.axis = .vertical
        stack.spacing = 25
        stack.distribution = .fillEqually
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 40, leading: 40, bottom: 40, trailing: 40)
//        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stack.topAnchor.constraint(equalTo: margins.topAnchor),
            stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
    }
}

#Preview {
    ViewController()
}
