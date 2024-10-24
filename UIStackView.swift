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
            colorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            colorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = 10
            stack.addArrangedSubview(colorView)
        }
    }
    
    func configureStacks() {
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

#Preview {
    ViewController()
}
