//
//  MyTicketsTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class MyTicketsTableViewCell: UITableViewCell {
    @IBOutlet weak var boardingLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ticketTimeLabel: UILabel!
    
    
    func setup(_ ticketModel: TicketModel) {
        seatNumberLabel.text = ticketModel.seatNumber
        dateLabel.text = ticketModel.Date.date
        ticketTimeLabel.text = ticketModel.Time.time
        boardingLabel.text = ticketModel.boarding
        destinationLabel.text = ticketModel.destination
        passengerNameLabel.text = ticketModel.passenger.name
    }
    
}
