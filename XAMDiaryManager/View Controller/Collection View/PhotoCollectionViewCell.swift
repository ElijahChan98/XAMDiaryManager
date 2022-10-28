//
//  PhotoCollectionViewCell.swift
//  XAMDiaryManager
//
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    weak var delegate: PhotoCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onCloseButtonClick(_ sender: Any) {
        self.delegate?.removePhoto(photoImageView.image!)
    }
    
}

protocol PhotoCollectionCellDelegate: AnyObject {
    func removePhoto(_ photo: UIImage)
}
