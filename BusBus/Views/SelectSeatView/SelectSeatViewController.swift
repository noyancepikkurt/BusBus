//
//  SelectSeatViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class SelectSeatViewController: UIViewController {
    @IBOutlet private weak var boardingLabel: UILabel!
    @IBOutlet private weak var destinationLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var timeStartedLabel: UILabel!
    @IBOutlet private weak var destinationTicketLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    var boardingLbl = String()
    var destinationLbl = String()
    var dateLbl = String()
    var timeStartedLbl = String()
    var price = Int()
    var selectedSeat = [String]()
    var boughtSeats = [String]()
    private var selectedSeatIndex = [Int]()
    private var koltukNo = ["A1","B1","","C1","D1","A2","B2","","C2","D2","A3","B3","","C3","D3","A4","B4","","C4","D4",
                            "A5","B5","","C5","D5","A6","B6","","C6","D6","A7","B7","","C7","D7","A8","B8","","C8","D8","A9","B9","","C9","D9","A10","B10","","C10","D10","A11","B11","","C11","D11","A12"]
    let selectedSeats = UserDefaults.standard.array(forKey: "buyingSeatArray")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        collectionViewConfig()
        labelsConfig()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func labelsConfig() {
        boardingLabel.text = boardingLbl
        destinationLabel.text = destinationLbl
        destinationTicketLabel.text = destinationLbl
        dateLabel.text = dateLbl
        timeStartedLabel.text = timeStartedLbl
        priceLabel.text = "\(price) ₺"
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if selectedSeatIndex.count == 0 {
            UIAlertController.alertMessage(title: "Üzgünüz", message: "Hiç Koltuk Seçmediniz", vc: self)
        } else if selectedSeatIndex.count <= 5 {
            performSegue(withIdentifier: "toUserVC", sender: nil)
        } else {
            UIAlertController.alertMessage(title: "Üzgünüz", message: "En fazla 5 tane koltuk seçebilirsiniz", vc: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserVC" {
            let destination = segue.destination as! UserViewController
            destination.buyingSeatArray = selectedSeat
            destination.totalPrice = selectedSeat.count * price
            destination.boarding = boardingLbl
            destination.destination = destinationLbl
            destination.date = dateLbl
            destination.timeStarted = timeStartedLbl
        }
    }
    private func registerCollectionViewCell() {
        collectionView.register(UINib(nibName: "SelectSeatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    private func collectionViewConfig() {
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 0
        design.minimumLineSpacing = 10
        let cellWidth = (width - 60) / 5
        design.itemSize = CGSize(width: cellWidth, height: cellWidth)
        collectionView.collectionViewLayout = design
    }
}

extension SelectSeatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        koltukNo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! SelectSeatCollectionViewCell
        cell.cornerRadius = 8
        cell.seatLabel.text = koltukNo[indexPath.item]
        
        if selectedSeatIndex.contains(indexPath.item) {
            cell.viewForSelection.backgroundColor = UIColor.red
        } else if koltukNo[indexPath.item] == "" {
            cell.viewForSelection.backgroundColor = UIColor.white
        }else {
            cell.viewForSelection.backgroundColor = UIColor.systemGray4
            let seatLabel = cell.seatLabel.text!
            if let selectedSeats = selectedSeats {
                for seatName in selectedSeats {
                    if let seatName = seatName as? String {
                        if seatLabel == seatName {
                            cell.seatLabel.text = "DOLU"
                            cell.viewForSelection.backgroundColor = .systemGray
                            cell.isUserInteractionEnabled = false
                        }
                    }
                }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedSeatIndex.contains(indexPath.item) {
            if let index = selectedSeatIndex.firstIndex(of: indexPath.item) {
                selectedSeatIndex.remove(at: index)
                selectedSeat.remove(at: index)
            }
        } else {
            selectedSeat.append(koltukNo[indexPath.item])
            selectedSeatIndex.append(indexPath.item)
        }
        collectionView.reloadData()
    }
}
