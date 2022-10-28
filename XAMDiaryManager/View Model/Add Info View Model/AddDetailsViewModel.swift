//
//  AddDetailsViewModel.swift
//  XAMDiaryManager
//
//

import Foundation

class AddDetailsViewModel: NSObject {
    var areas = ["Loc 1", "Loc 2", "Loc 3"]
    var taskCategories = ["Task 1", "Task 2", "Task 3"]
    
    var selectedDate: String = ""
    var selectedArea: String = ""
    var selectedTaskCategory: String = ""
    var tags: [String] = []
    
    func collectData(selectedArea: String, selectedTaskCategory: String, tags: [String]) {
        self.selectedArea = selectedArea
        self.selectedTaskCategory = selectedTaskCategory
        self.tags = tags
    }
}


