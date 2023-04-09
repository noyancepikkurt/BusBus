//
//  MyTicketsViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class MyTicketsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var selectedBuyingSeats = [String]()
    var boardingCity = String()
    var destinationCity = String()
    var ticketDate = String()
    var ticketTimeStarted = String()
    var passengerNames = [String]()
    var passengerId = [String]()
    var qr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getData(notification:)), name: .notificationName, object: nil)
        tableViewRegister()
        tableViewConfig()
    }
    
    private func tableViewConfig() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func getData(notification:NSNotification) {
        selectedBuyingSeats = notification.userInfo!["buyingSeatArray"] as! [String]
        boardingCity = notification.userInfo!["boarding"] as! String
        destinationCity = notification.userInfo!["destination"] as! String
        ticketDate = notification.userInfo!["date"] as! String
        ticketTimeStarted = notification.userInfo!["timeStarted"] as! String
        passengerNames = notification.userInfo!["passengerNames"] as! [String]
        passengerId = notification.userInfo!["passengerId"] as! [String]
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "MyTicketsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTicketsCell")
    }
}

extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBuyingSeats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketsCell") as! MyTicketsTableViewCell
        //QR
        let combinedString = "Bilet Sahibi: \(passengerNames[indexPath.row])\nBilet ID: \(passengerId[indexPath.row])\nKoltuk Numaran: \(selectedBuyingSeats[indexPath.row])\nTarih: \(ticketDate)"
        let nameData = combinedString.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(nameData, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                qr.append(UIImage(ciImage: output))
            }
        }
        
        let ticketModel = TicketModel(passenger: PassengerModel(name: passengerNames[indexPath.row], id: passengerId[indexPath.row]), Date: DateModel(date: ticketDate), Time: TimeModel(time: ticketTimeStarted), seatNumber: selectedBuyingSeats[indexPath.row], boarding: boardingCity, destination: destinationCity,qr: qr[indexPath.row])
        cell.setup(ticketModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
}

