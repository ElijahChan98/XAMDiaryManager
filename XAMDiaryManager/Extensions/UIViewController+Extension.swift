//
//  UIViewController+Extension.swift
//  XAMDiaryManager
//
//  Created by Elijah Chan on 10/29/22.
//

import Foundation
import UIKit

extension UIViewController {
    func addShadowAndCornerRadius() {
        self.view.addShadow()
        self.view.layer.cornerRadius = 5.0
    }
}
