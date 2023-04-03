//
//  MyTicketsTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

class MyTicketsTableViewCell: UITableViewCell {
    @IBOutlet weak var boardingLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ticketTimeLabel: UILabel!
    
    func setup(_ ticketModel: TicketModel) {
        ticketModel.passenger
    }
    
}
