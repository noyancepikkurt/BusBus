//
//  MyProfileViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 9.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

final class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageConfig()
        getDataFromFireDatabase()
    }
    
    private func getDataFromFireDatabase() {
        profileLabel.text = Auth.auth().currentUser?.email
        let firestoreDatabase = Firestore.firestore()
        let collectionRef = firestoreDatabase.collection("ProfileImages")
        
        collectionRef.addSnapshotListener { snapshot, error in
            if error != nil {
                UIAlertController.alertMessage(title: "Hata", message: error!.localizedDescription , vc: self)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for _ in snapshot!.documents {
                        let query = collectionRef.whereField("imageBy", isEqualTo: Auth.auth().currentUser?.email as Any)
                        
                        query.getDocuments { (snapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                for document in snapshot!.documents {
                                    if let imageUrl = document.get("imageUrl") as? String {
                                        self.profileImageView.sd_setImage(with: URL(string: imageUrl))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func imageConfig() {
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.red.cgColor
        self.profileImageView.layer.masksToBounds = false
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        self.profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = profileImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    UIAlertController.alertMessage(title: "Hata", message: error?.localizedDescription ?? "Hata", vc: self)
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            guard let imageUrl = imageUrl else { return }
                            
                            let query = firestoreDatabase.collection("ProfileImages").whereField("imageBy", isEqualTo: Auth.auth().currentUser?.email as Any)
                            query.getDocuments { (snapshot, error) in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    if let document = snapshot?.documents.first {
                                        document.reference.updateData(["imageUrl":imageUrl])
                                    } else {
                                        let fireStoreImages = ["imageUrl":imageUrl,"imageBy":Auth.auth().currentUser?.email]
                                        firestoreDatabase.collection("ProfileImages").addDocument(data: fireStoreImages as [String : Any]) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        getDataFromFireDatabase()
    }
}
