//
//  ReqresError.swift
//  XAMDiaryManager
//
//

import Foundation

public struct ReqresError: Codable {
    enum CodingKeys: String, CodingKey {
        case message
        case code
        case stat
    }
    var message: String
    var code: Int
    var stat: String
}
