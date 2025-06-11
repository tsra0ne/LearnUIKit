//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

// Layout: https://developer.apple.com/design/human-interface-guidelines/layout

// Observing Changes in Size Classes Prior to iOS 17

class ViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let horizontal = traitCollection.horizontalSizeClass
        let vertical = traitCollection.verticalSizeClass
        
        let horizontalSizeClass = horizontal == .compact ? "Compact" : "Regular"
        let verticalSizeClass = vertical == .compact ? "Compact" : "Regular"
        
        label.text = "HSizeClass: \(horizontalSizeClass) | VSizeClass: \(verticalSizeClass)"
    }

    func setupUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerY.equalToSuperview()
        }
    }

}

class NewViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        observeTraitChanges()
    }
    
    func observeTraitChanges() {
        if #available(iOS 17.0, *) {
            let traits: [UITrait] = [UITraitHorizontalSizeClass.self, UITraitVerticalSizeClass.self]
            
            registerForTraitChanges(traits) { (traitEnvironment: UITraitEnvironment, previousTraitCollection) in
                let horizontal = traitEnvironment.traitCollection.horizontalSizeClass
                let vertical = traitEnvironment.traitCollection.verticalSizeClass
                
                let horizontalSizeClass = horizontal == .compact ? "Compact" : "Regular"
                let verticalSizeClass = vertical == .compact ? "Compact" : "Regular"
                
                self.label.text = "HSizeClass: \(horizontalSizeClass) | VSizeClass: \(verticalSizeClass)"
            }
        } else {
            // Fallback on earlier versions
        }
        
    }

    func setupUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerY.equalToSuperview()
        }
    }

}
