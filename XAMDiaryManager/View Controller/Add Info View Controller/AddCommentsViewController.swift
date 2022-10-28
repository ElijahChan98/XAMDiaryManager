//
//  AddCommentsViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class AddCommentsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var commentsTextField: UITextField!
    private var viewModel: AddCommentsViewModel!
    
    init(viewModel: AddCommentsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTextField.delegate = self
        self.addShadowAndCornerRadius()
        // Do any additional setup after loading the view.
    }
    
    func updateViewModel() {
        viewModel.comments = commentsTextField.text ?? ""
    }
}
