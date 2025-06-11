//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    func setupUI() {
        button.setTitle("Share", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func shareTapped(_ sender: UIButton) {
        let url = URL(string: "https://swiftrivals.com/blog/integrating-swiftui-into-uikit")!
        let activityViewController = UIActivityViewController(activityItems: [ url ], applicationActivities: nil)
        present(activityViewController, animated: true)
    }

}

