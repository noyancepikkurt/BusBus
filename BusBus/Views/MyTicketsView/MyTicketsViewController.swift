//
//  MyTicketsViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class MyTicketsViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
    
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
        navigationController?.navigationBar.isHidden = true
        tabBarController?.selectedIndex = 1
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

