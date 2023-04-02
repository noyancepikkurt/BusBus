//
//  FindBusViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

class FindBusViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var boardingLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var findBusCellArray = [FindBusModel]()
    var boarding = ""
    var destination = ""
    var date = ""
    var startedTime = ""
    var finishedTime = ["08:30","10:30","10:45","09:00","14:00","13:00"]
    var price = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        boardingLabel.text = boarding
        destinationLabel.text = destination
        dateLabel.text = date
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "FindBusTableViewCell", bundle: nil), forCellReuseIdentifier: "FindBusCell")
    }
}

extension FindBusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return findBusCellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindBusCell", for: indexPath) as! FindBusTableViewCell
        cell.setup(findBusCellArray[indexPath.row])
        startedTime = findBusCellArray[indexPath.row].timeLabel!
        price = findBusCellArray[indexPath.row].priceLabel!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSelectSeatVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectSeatVC" {
            let destination = segue.destination as? SelectSeatViewController
            destination?.boardingLbl = self.boarding
            destination?.destinationLbl = self.destination
            destination?.dateLbl = self.date
            destination?.destinationLbl = self.destination
            destination?.timeStartedLbl = startedTime
            destination?.priceLbl = price
        }
    }
}
