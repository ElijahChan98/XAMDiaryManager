//
//  TagsTextfieldViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class TagsTextfieldViewController: UIViewController, UITextFieldDelegate, TagsTextfieldViewModelDelegate {
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    private var tagsCollectionViewIsShown: Bool = false
    private var viewModel: TagsTextfieldViewModel!
    
    init(viewModel: TagsTextfieldViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsTextField.delegate = self
        viewModel.delegate = self
        setupCollectionView()
    }
    
    func updateCollectionView(_ tags: [String]) {
        if viewModel.tags.count > 0 {
            setupTagsCollectionView()
        } else if viewModel.tags.count == 0 {
            tagsCollectionView.isHidden = true
            tagsCollectionViewIsShown = false
        }
        tagsCollectionView.reloadData()
        tagsCollectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        tagsCollectionView.collectionViewLayout = layout
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
    }
    
    private func setupTagsCollectionView() {
        guard !tagsCollectionViewIsShown else { return }
        tagsCollectionViewIsShown = true
        tagsCollectionView.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
                text != "",
                !viewModel.tags.contains(text) else {
            textField.resignFirstResponder()
            return true
        }
        viewModel.tags.append(text)
        textField.resignFirstResponder()
        return true
    }
}

extension TagsTextfieldViewController: UICollectionViewDelegate, UICollectionViewDataSource, TagCollectionViewCellDelegate {
    func removeTag(_ tag: String) {
        viewModel.removeTag(tag)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagCollectionViewCell
        cell?.tagLabel.text = viewModel.tags[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
}
