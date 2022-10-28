//
//  UIButton+Extension.swift
//  XAMDiaryManager
//
//  Created by Elijah Chan on 10/29/22.
//

import Foundation
import UIKit

extension UIButton {
    func addShadowAndCornerRadius() {
        self.addShadow()
        self.layer.cornerRadius = 5.0
    }
}
