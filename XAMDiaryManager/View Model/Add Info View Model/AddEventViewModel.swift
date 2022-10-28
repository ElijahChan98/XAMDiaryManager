//
//  AddEventViewModel.swift
//  XAMDiaryManager
//
//

import Foundation

class AddEventViewModel: NSObject {
    var isChecked: Bool = false
    var events = ["Event 1", "Event 2", "Event 3"]
    
    var selectedEvent: String?
    
    func collectData(selectedEvent: String?) {
        self.selectedEvent = selectedEvent
    }
}
