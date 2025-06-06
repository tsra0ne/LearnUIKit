//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import  SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationItem.title = "Primary"
        
        let button = UIButton(type: .system)
        button.setTitle("Show Detail", for: .normal)
        button.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func showDetail() {
        let detailVC = SecondViewController()
        splitViewController?.showDetailViewController(UINavigationController(rootViewController: detailVC), sender: nil)
    }
    
}

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Detail"
        
        let label = UILabel()
        label.text = "Detail Content"
        label.textAlignment = .center
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // Add display mode button
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
}
