//
//  AddDetailsViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class AddDetailsViewController: UIViewController {
    @IBOutlet weak var datePickerField: UITextField!
    @IBOutlet weak var containerStackView: UIStackView!
    var selectAreaPicker: DropdownTextfieldViewController!
    var taskCategoryPicker: DropdownTextfieldViewController!
    var tagsTextFieldViewController: TagsTextfieldViewController!
    private var viewModel: AddDetailsViewModel!
    private var tagsViewModel: TagsTextfieldViewModel!
    
    init(viewModel: AddDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        datePickerField.inputAccessoryView = toolBar
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
    }

    private func setupPickers() {
        datePickerField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePickerField.text = dateFormatter.string(from: Date())
        
        selectAreaPicker = DropdownTextfieldViewController(choices: viewModel.areas, placeholder: "Select Area")
        containerStackView.addArrangedSubview(selectAreaPicker.view)
        
        taskCategoryPicker = DropdownTextfieldViewController(choices: viewModel.taskCategories, placeholder: "Task Category")
        containerStackView.addArrangedSubview(taskCategoryPicker.view)
        
        tagsViewModel = TagsTextfieldViewModel()
        tagsTextFieldViewController = TagsTextfieldViewController(viewModel: tagsViewModel)
        containerStackView.addArrangedSubview(tagsTextFieldViewController.view)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePickerField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func datePickerDone() {
        datePickerField.resignFirstResponder()
        viewModel.selectedDate = datePickerField.text!
    }
    
    func updateViewModel() {
        viewModel.collectData(selectedArea: selectAreaPicker.selectedChoice, selectedTaskCategory: taskCategoryPicker.selectedChoice, tags: tagsViewModel.tags)
    }
}
