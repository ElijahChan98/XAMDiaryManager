//
//  UIView+Extension.swift
//  XAMDiaryManager
//
//  Created by Elijah Chan on 10/29/22.
//

import Foundation
import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
    }
}
