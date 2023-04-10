//
//  MyTicketsTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class MyTicketsTableViewCell: UITableViewCell {
    @IBOutlet private weak var boardingLabel: UILabel!
    @IBOutlet private weak var destinationLabel: UILabel!
    @IBOutlet private weak var passengerNameLabel: UILabel!
    @IBOutlet private weak var seatNumberLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ticketTimeLabel: UILabel!
    @IBOutlet private weak var passengerIdLabel: UILabel!
    @IBOutlet private var cellImageView: UIImageView!
    
    func setup(_ ticketModel: TicketModel) {
        seatNumberLabel.text = ticketModel.seatNumber
        dateLabel.text = ticketModel.Date.date
        ticketTimeLabel.text = ticketModel.Time.time
        boardingLabel.text = ticketModel.boarding
        destinationLabel.text = ticketModel.destination
        passengerNameLabel.text = ticketModel.passenger.name
        passengerIdLabel.text = ticketModel.passenger.id
        cellImageView.image = ticketModel.qr
    }
}
