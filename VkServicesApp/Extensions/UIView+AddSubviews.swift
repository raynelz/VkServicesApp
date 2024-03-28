//
//  UIView+AddSubviews.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 28.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
