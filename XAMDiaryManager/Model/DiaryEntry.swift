//
//  DiaryEntry.swift
//  XAMDiaryManager
//
//

import Foundation
import UIKit

struct DiaryEntry {
    var photos: [UIImage]
    var comments: String
    var date: String
    var area: String
    var taskCategory: String
    var tags: [String]
    var event: String?
    
    static func getPhotoData(_ photo: UIImage) -> String? {
        let imageData = photo.jpegData(compressionQuality: 1)!
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
}
