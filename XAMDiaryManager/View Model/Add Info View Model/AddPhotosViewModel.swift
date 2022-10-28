//
//  AddPhotosViewModel.swift
//  XAMDiaryManager
//
//

import Foundation
import UIKit

class AddPhotosViewModel: NSObject {
    weak var delegate: AddPhotosViewModelDelegate?
    var isChecked: Bool = false
    var photos: [UIImage] = [] {
        didSet {
            delegate?.updateCollectionViews(photos)
        }
    }
    
    func removePhoto(_ photo: UIImage) {
        photos = photos.filter {$0 !== photo}
    }
}

protocol AddPhotosViewModelDelegate: AnyObject {
    func updateCollectionViews(_ photos: [UIImage])
}
