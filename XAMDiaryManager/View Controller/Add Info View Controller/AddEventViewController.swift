//
//  AddEventViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class AddEventViewController: UIViewController {
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var checkedButton: UIButton!
    var existingEventPicker: DropdownTextfieldViewController!
    private var viewModel: AddEventViewModel!
    
    init(viewModel: AddEventViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        self.addShadowAndCornerRadius()
    }
    
    private func setupPicker() {
        existingEventPicker = DropdownTextfieldViewController(choices: viewModel.events, placeholder: "Select an event")
        containerStackView.addArrangedSubview(existingEventPicker.view)
        existingEventPicker.view.isHidden = true
    }
    
    @IBAction func onCheckboxClick(_ sender: Any) {
        if viewModel.isChecked {
            checkedButton.setImage(UIImage(named: "unchecked"), for: .normal)
            existingEventPicker.view.isHidden = true
        } else {
            checkedButton.setImage(UIImage(named: "checked"), for: .normal)
            existingEventPicker.view.isHidden = false
        }
        viewModel.isChecked.toggle()
    }
    
    func updateViewModel() {
        viewModel.collectData(selectedEvent: existingEventPicker.selectedChoice)
    }
}
