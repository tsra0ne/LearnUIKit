//
//  UIView+Extension.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 28/05/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
