//
//  UIStackView+Extension.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 07/06/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
