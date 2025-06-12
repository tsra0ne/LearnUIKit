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
        button.setTitle("Show Sheet", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let sheetViewController = SheetViewController()
        sheetViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = sheetViewController.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("custom")) { context in
                return context.maximumDetentValue * 0.3
            }
            sheet.detents = [customDetent, .medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true // Attach to bottom in compact height
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false // Prevent scrolling from expanding detent
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.selectedDetentIdentifier = .medium
            sheet.preferredCornerRadius = 20 // Round corners
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true // Respect preferredContentSize
        }
        
        present(sheetViewController, animated: true)
    }

}

class SheetViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemRed
        super.viewDidLoad()
        button.setTitle("Dismiss Sheet", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
