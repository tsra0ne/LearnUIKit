//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        setupSegmentedControl()
        view.addSubview(segmentedControl)
        setupConstraints()
    }
    
    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.backgroundColor = .systemGray6
    }
    
    func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func segmentChanged(sender: UISegmentedControl) {
        NSLog("Selected segment index: \(sender.selectedSegmentIndex)")
    }

}

