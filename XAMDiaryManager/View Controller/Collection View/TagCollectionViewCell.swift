//
//  TagCollectionViewCell.swift
//  XAMDiaryManager
//
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    weak var delegate: TagCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.bringSubviewToFront(containerView)
        self.containerView.layer.cornerRadius = 20.0
    }
    
    @IBAction func onCloseButtonClick(_ sender: Any) {
        delegate?.removeTag(tagLabel.text!)
        
    }
}

protocol TagCollectionViewCellDelegate: AnyObject {
    func removeTag(_ tag: String)
}
