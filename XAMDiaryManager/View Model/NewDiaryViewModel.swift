//
//  NewDiaryViewModel.swift
//  XAMDiaryManager
//
//

import Foundation
import UIKit

class NewDiaryViewModel: NSObject, LocationManagerDelegate {
    var viewTitle = "New Diary"
    var address: String = "No location found"
    weak var delegate: NewDiaryViewModelDelegate?
    
    func getLocation() {
        LocationManager.shared.getLocation()
        LocationManager.shared.locationDelegate = self
    }
    
    func didReceiveAddress(_ address: String) {
        self.address = address
        delegate?.onAddressReceive(address)
    }
    
    func uploadNewDiary(_ diaryEntry: DiaryEntry, completion: @escaping ((Bool) -> ())) {
        NewDiaryManager.shared.postDiaryDetails(diaryEntry: diaryEntry) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    guard let response = response as? [String: Any] else {
                        return
                    }
                    print(response)
                    completion(true)
                case .failure(let error):
                    //handle errors
                    if let error = error {
                        print(error)
                    }
                    completion(false)
                }
            }
        }
    }
}

protocol NewDiaryViewModelDelegate: AnyObject {
    func onAddressReceive(_ address: String)
}
