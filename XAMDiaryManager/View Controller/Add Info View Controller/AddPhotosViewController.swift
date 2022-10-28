//
//  AddPhotosViewController.swift
//  XAMDiaryManager
//
//

import UIKit

class AddPhotosViewController: UIViewController, PhotoCollectionCellDelegate, AddPhotosViewModelDelegate {
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var checkedButton: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private var photosCollectionIsShown: Bool = false
    private var viewModel: AddPhotosViewModel!
    
    init(viewModel: AddPhotosViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        addPhotoButton.setTitleColor(.white, for: .normal)
        addPhotoButton.backgroundColor = UIColor(named: "brightgreen")
        setupCollectionView()
    }
    
    func updateCollectionViews(_ photos: [UIImage]) {
        if photos.count > 0 {
            setupPhotosCollectionView()
        } else if photos.count == 0 {
            photosCollectionView.isHidden = true
            photosCollectionIsShown = false
        }
        photosCollectionView?.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        photosCollectionView.collectionViewLayout = layout
        photosCollectionView?.delegate = self
        photosCollectionView?.dataSource = self
        photosCollectionView?.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
    }
    
    private func setupPhotosCollectionView() {
        guard !photosCollectionIsShown else { return }
        photosCollectionIsShown = true
        photosCollectionView.isHidden = false
    }
    
    @IBAction func onCheckboxClick(_ sender: Any) {
        if viewModel.isChecked {
            checkedButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            checkedButton.setImage(UIImage(named: "checked"), for: .normal)
        }
        viewModel.isChecked.toggle()
    }
    
    @IBAction func onAddPhotoClick(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let vc = UIImagePickerController()
                vc.sourceType = .camera
                vc.allowsEditing = true
                self.present(vc, animated: true, completion: nil)
            } else {
                Utilities.showGenericOkAlert(title: nil, message: "No camera found")
            }
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            let vc = UIImagePickerController()
            vc.sourceType = .savedPhotosAlbum
            vc.allowsEditing = false
            vc.delegate = self
            self.present(vc, animated: true)
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        self.present(alert, animated: true)
    }
    
    func removePhoto(_ photo: UIImage) {
        viewModel.removePhoto(photo)
    }
    
}

extension AddPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
        cell?.photoImageView.image = viewModel.photos[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension AddPhotosViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        viewModel.photos.append(image)
        guard viewModel.isChecked else { return }
        // Cannot test save to gallery because simulator has no camera
        //UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}
