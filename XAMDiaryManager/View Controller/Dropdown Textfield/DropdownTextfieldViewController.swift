//
//  DropdownTextfieldViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class DropdownTextfieldViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    var dropdownPicker: UIPickerView! = UIPickerView()
    var choices: [String] = []
    var placeholder: String!
    var selectedChoice: String = ""
    
    init(choices: [String], placeholder: String = "") {
        super.init(nibName: nil, bundle: nil)
        self.placeholder = placeholder
        self.choices = choices
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        self.textField.placeholder = placeholder
        setupDropdown()
    }
    
    private func setupDropdown() {
        self.dropdownPicker.delegate = self
        self.dropdownPicker.dataSource = self
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.pickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        textField.inputAccessoryView = toolBar
        textField.inputView = dropdownPicker
    }
    
    @objc func pickerDone() {
        textField.resignFirstResponder()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = self.choices[row]
        selectedChoice = textField.text ?? ""
    }
}
