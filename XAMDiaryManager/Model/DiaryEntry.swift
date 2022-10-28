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
        return photo.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
