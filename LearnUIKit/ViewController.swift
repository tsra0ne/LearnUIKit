//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let segmentControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
    let selectedSegmentIndex = UserDefaults.standard.integer(forKey: "com.swiftrivals.LearnUIKit.selectedSegmentIndex")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        segmentControl.selectedSegmentIndex = selectedSegmentIndex
        segmentControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "com.swiftrivals.LearnUIKit.selectedSegmentIndex")
    }

}

