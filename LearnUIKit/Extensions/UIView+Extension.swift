//
//  UIView+Extension.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 21/02/25.
//

import UIKit

extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
