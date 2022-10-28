//
//  DiaryEntryDummyData.swift
//  XAMDiaryManagerTests
//
//

import Foundation

struct Constants {
    static let dummyDiaryEntryPost: [String: Any] = [
        "photos": ["0" : "photo 0",
                    "1" : "photo 1",
                    "2" : "photo 2"
                   ],
        "comments": "test comment",
        "date": "06/11/1997",
        "area": "Test area 1",
        "taskCategory": "Test category 1",
        "tags": ["tags 1",
                 "tags 2",
                 "tags 3"
                ],
        "event": "event 1"
    ]
    
    static let dummyDiaryEntryResponse: [String: Any] = [
        "photos": [
                    "0": "photo 0",
                    "1": "photo 1",
                    "2": "photo 2"
            ],
            "comments": "test comment",
            "date": "06/11/1997",
            "area": "Test area 1",
            "taskCategory": "Test category 1",
            "tags": [
                "tags 1",
                "tags 2",
                "tags 3"
            ],
            "event": "event 1",
    ]
}
