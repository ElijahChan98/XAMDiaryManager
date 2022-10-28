//
//  NewDiaryViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class NewDiaryViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var locationContainerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var infoButton: UIImageView!
    private var addPhotosViewController: AddPhotosViewController!
    private var addCommentsViewController: AddCommentsViewController!
    private var addDetailsViewController: AddDetailsViewController!
    private var addEventViewController: AddEventViewController!
    private var nextButton: UIButton!
    private var viewModel: NewDiaryViewModel!
    
    private var addPhotosViewModel: AddPhotosViewModel!
    private var addCommentsViewModel: AddCommentsViewModel!
    private var addDetailsViewModel: AddDetailsViewModel!
    private var addEventViewModel: AddEventViewModel!
    
    init(viewModel: NewDiaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel.viewTitle
        viewModel.delegate = self
        viewModel.getLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onInfoButtonClick))
        infoButton.addGestureRecognizer(tapGesture)
        setupStackView()
    }
    
    private func setupStackView() {
        addPhotosViewModel = AddPhotosViewModel()
        addPhotosViewController = AddPhotosViewController(viewModel: addPhotosViewModel)
        containerStackView.addArrangedSubview(addPhotosViewController.view)
        
        addCommentsViewModel = AddCommentsViewModel()
        addCommentsViewController = AddCommentsViewController(viewModel: addCommentsViewModel)
        containerStackView.addArrangedSubview(addCommentsViewController.view)
        
        addDetailsViewModel = AddDetailsViewModel()
        addDetailsViewController = AddDetailsViewController(viewModel: addDetailsViewModel)
        containerStackView.addArrangedSubview(addDetailsViewController.view)
        
        addEventViewModel = AddEventViewModel()
        addEventViewController = AddEventViewController(viewModel: addEventViewModel)
        containerStackView.addArrangedSubview(addEventViewController.view)
        
        nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(named: "brightgreen")
        containerStackView.addArrangedSubview(nextButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onNextButtonClick))
        nextButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func onInfoButtonClick() {
        let popup = NewDiaryInfoPopupViewController()
        popup.modalPresentationStyle = .popover
        popup.preferredContentSize = .init(width: self.view.bounds.width - 10, height: 150)
        popup.popoverPresentationController?.sourceView = infoButton
        popup.popoverPresentationController?.sourceRect = infoButton.bounds
        popup.popoverPresentationController?.delegate = self
        
        self.present(popup, animated: true)
    }
    
    @objc func onNextButtonClick() {
        addCommentsViewController.updateViewModel()
        addDetailsViewController.updateViewModel()
        addEventViewController.updateViewModel()
        let photos = addPhotosViewModel.photos
        let comments = addCommentsViewModel.comments
        let date = addDetailsViewModel.selectedDate
        let area = addDetailsViewModel.selectedArea
        let taskCategory = addDetailsViewModel.selectedTaskCategory
        let tags = addDetailsViewModel.tags
        let event = addEventViewModel.selectedEvent
        
        let entry = DiaryEntry(photos: photos, comments: comments, date: date, area: area, taskCategory: taskCategory, tags: tags, event: event)
        
        viewModel.uploadNewDiary(entry)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension NewDiaryViewController: NewDiaryViewModelDelegate {
    func onAddressReceive(_ address: String) {
        self.locationLabel.text = address
    }
}
