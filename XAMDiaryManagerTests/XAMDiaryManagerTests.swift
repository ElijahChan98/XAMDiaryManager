//
//  XAMDiaryManagerTests.swift
//  XAMDiaryManagerTests
//
//

import XCTest
@testable import XAMDiaryManager

class XAMDiaryManagerTests: XCTestCase, LocationManagerDelegate {
    var diaryEntry: DiaryEntry?

    func testCodableObjectFactory() {
        //let diaryEntryPostDummy = Constants.dummyDiaryEntryPost
    }
    
    func testDiaryEntryImageData() {
        let sampleImage = UIImage(named: "locationpin")
        let decodedData = DiaryEntry.getPhotoData(sampleImage!)
        XCTAssert(decodedData != "")
    }
    
    func testLocationManager() {
        LocationManager.shared.getLocation()
        LocationManager.shared.locationDelegate = self
    }
    
    func didReceiveAddress(_ address: String) {
        XCTAssert(address != "")
    }
    
    func testRemovePhoto() {
        let viewModel = AddPhotosViewModel()
        viewModel.photos = [UIImage(named: "locationpin")!, UIImage(named: "help")!]
        viewModel.removePhoto(UIImage(named: "locationpin")!)
        XCTAssert(viewModel.photos == [UIImage(named: "help")!])
    }
    
    func testRemoveTag() {
        let viewModel = TagsTextfieldViewModel()
        viewModel.tags = ["tag 1", "Tag 2", "tag 3"]
        viewModel.removeTag("Tag 2")
        XCTAssert(viewModel.tags == ["tag 1", "tag 3"])
    }
}
