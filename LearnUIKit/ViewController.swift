//
//  ViewController.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Configure scroll view
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .automatic
        
        // Add content view
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        // Add sample content
        let label = UILabel()
        label.text = "Scrollable Content"
        label.textAlignment = .center
        contentView.addSubview(label)
        
        // Auto Layout for scroll view
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Auto Layout for content view
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView.contentSize.height)
        }
        
        // Auto Layout for label
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        // Accessibility
        scrollView.accessibilityLabel = "Content scroll view"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSLog("Scrolled to: \(scrollView.contentOffset.y)")
    }

}

