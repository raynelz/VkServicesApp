//
//  UIView+AddSubviews.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
