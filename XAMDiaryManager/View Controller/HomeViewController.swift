//
//  HomeViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
    }


    @IBAction func onAddNewDiaryButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(NewDiaryViewController(viewModel: NewDiaryViewModel()), animated: true)
    }
}
