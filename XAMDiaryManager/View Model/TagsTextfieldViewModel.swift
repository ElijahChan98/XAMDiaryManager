//
//  TagsTextfieldViewModel.swift
//  XAMDiaryManager
//
//

import Foundation

class TagsTextfieldViewModel: NSObject {
    weak var delegate: TagsTextfieldViewModelDelegate?
    var tags: [String] = [] {
        didSet {
            delegate?.updateCollectionView(tags)
        }
    }
    
    func removeTag(_ tag: String) {
        tags = tags.filter { $0 != tag }
    }
}

protocol TagsTextfieldViewModelDelegate: AnyObject {
    func updateCollectionView(_ tags: [String])
}
