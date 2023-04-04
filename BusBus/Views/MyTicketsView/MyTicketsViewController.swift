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
    var passengerAges = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        NotificationCenter.default.addObserver(self, selector: #selector(getData(notification:)), name: .notificationName, object: nil)
    }
    
    @objc func getData(notification:NSNotification) {
        selectedBuyingSeats = notification.userInfo!["buyingSeatArray"] as! [String]
        boardingCity = notification.userInfo!["boarding"] as! String
        destinationCity = notification.userInfo!["destination"] as! String
        ticketDate = notification.userInfo!["date"] as! String
        ticketTimeStarted = notification.userInfo!["timeStarted"] as! String
        passengerNames = notification.userInfo!["passengerNames"] as! [String]
        passengerAges = notification.userInfo!["passengerAges"] as! [Int]
        
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
        let ticketModel = TicketModel(passenger: PassengerModel(name: passengerNames[indexPath.row], age: "23"), Date: DateModel(date: ticketDate), Time: TimeModel(time: ticketTimeStarted), seatNumber: selectedBuyingSeats[indexPath.row], boarding: boardingCity, destination: destinationCity)
        cell.setup(ticketModel)
        return cell
    }
}
