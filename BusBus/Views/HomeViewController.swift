//
//  HomeViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

final class HomeViewController: UIViewController {
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var boardingFromTextField: UITextField!
    @IBOutlet private weak var destinationTextField: UITextField!
    @IBOutlet private weak var heyLabel: UILabel!
    @IBOutlet private var profileImage: UIImageView!
    private var datePicker: UIDatePicker?
    private var boardingPickerView = UIPickerView()
    private var destinationPickerView = UIPickerView()
    private var cities = [String]()
    private let toolBar = UIToolbar()
    private let time = [8,10,9,7,11,10]
    private var findBusModel = [FindBusModel]()
    private var dateFormatter = DateFormatter()
    private var price = [400,350,300,350,400,300]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.red
        datePickerConfig()
        citiesConfig()
        pickerViewConfig()
        toolBarConfig()
        profileImageConfig()
        getDataFromFirestore()
    }
    
    private func profileImageConfig() {
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.red.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    
    @IBAction func findBusButtonAction(_ sender: Any) {
        if boardingFromTextField.text == "" || destinationTextField.text == "" {
            UIAlertController.alertMessage(title: "Hata", message: "Binilen veya gidilecek yer girilmedi", vc: self)
        } else if dateTextField.text == "" {
            UIAlertController.alertMessage(title: "Hata", message: "Tarih Girilmedi", vc: self)
        } else if boardingFromTextField.text == destinationTextField.text {
            UIAlertController.alertMessage(title: "Hata", message: "Aynı Şehirler arası gidemezsiniz", vc: self)
        } else {
            performSegue(withIdentifier: "toFindBusVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFindBusVC" {
            let destination = segue.destination as? FindBusViewController
            destination?.findBusCellArray = [FindBusModel(imageView: UIImage(named: "kamil_koc")!, timeLabel: "00:00", timeLeftLabel: "\(time[0])s 30dk", priceLabel: (price[0]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text), FindBusModel(imageView: UIImage(named: "pamukkale")!, timeLabel: "00:30", timeLeftLabel: "\(time[1])s", priceLabel: (price[1]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text),  FindBusModel(imageView: UIImage(named: "metro")!, timeLabel: "01:00", timeLeftLabel: "\(time[2])s 45dk", priceLabel: (price[2]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text), FindBusModel(imageView: UIImage(named: "varan")!, timeLabel: "02:00", timeLeftLabel: "\(time[3])s", priceLabel: (price[3]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text), FindBusModel(imageView: UIImage(named: "ben_turizm")!, timeLabel: "02:30", timeLeftLabel: "\(time[4])s 30dk", priceLabel: (price[4]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text), FindBusModel(imageView: UIImage(named: "izmir_turizm")!, timeLabel: "03:00", timeLeftLabel: "\(time[5])s", priceLabel: (price[5]), dateLabel:dateTextField.text, boardingFromLabel: boardingFromTextField.text, destinationLabel: destinationTextField.text)]
            destination?.boarding = boardingFromTextField.text!
            destination?.destination = destinationTextField.text!
            destination?.date = dateTextField.text!
        }
    }
    
    private func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        let collectionRef = firestoreDatabase.collection("ProfileImages")
        collectionRef.addSnapshotListener { snapshot, error in
            if error != nil {
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        _ = document.documentID
                        
                        let query = collectionRef.whereField("imageBy", isEqualTo: Auth.auth().currentUser?.email as Any)
                        query.getDocuments { (snapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                for document in snapshot!.documents {
                                    if let imageUrl = document.get("imageUrl") as? String {
                                        self.profileImage.sd_setImage(with: URL(string: imageUrl))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func todayButtonAction(_ sender: Any) {
        let date = Date()
        dateFormatter.dateFormat = "dd.MM.yy"
        let result = dateFormatter.string(from: date)
        dateTextField.text = result
    }
    
    @IBAction func tomorrowButtonAction(_ sender: Any) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = calendar.date(byAdding: dateComponents, to: Date())!
        dateFormatter.dateFormat = "dd.MM.yy"
        let result = dateFormatter.string(from: tomorrow)
        dateTextField.text = result
    }
    
    private func datePickerConfig() {
        datePicker = UIDatePicker()
        dateTextField.attributedPlaceholder = NSAttributedString(string: "Tarih Seçiniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray6])
        datePicker?.datePickerMode = .date
        dateTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(showDate(datePicker:)), for: .valueChanged)
    }
    
    @objc func showDate(datePicker: UIDatePicker) {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let takenDate = dateFormatter.string(from: datePicker.date)
        dateTextField.text = takenDate
    }
    
    private func citiesConfig() {
        cities = ["Adana", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
        boardingFromTextField.inputView = boardingPickerView
        destinationTextField.inputView = destinationPickerView
    }
    
    private func pickerViewConfig() {
        boardingPickerView.delegate = self
        boardingPickerView.dataSource = self
        destinationPickerView.delegate = self
        destinationPickerView.dataSource = self
    }
    
    private func toolBarConfig() {
        toolBar.tintColor = .red
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(cancelButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(okButtonAction))
        
        toolBar.setItems([cancelButton,spaceButton,okButton], animated: true)
        boardingFromTextField.inputAccessoryView = toolBar
        destinationTextField.inputAccessoryView = toolBar
    }
    
    @objc func okButtonAction() {
        view.endEditing(true)
    }
    
    @objc func cancelButtonAction() {
        view.endEditing(true)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == boardingPickerView {
            boardingFromTextField.text = cities[row]
        } else {
            destinationTextField.text = cities[row]
        }
    }
}
