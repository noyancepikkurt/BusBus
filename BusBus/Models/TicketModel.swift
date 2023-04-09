//
//  TicketModel.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

struct TicketModel {
    var passenger: PassengerModel
    var Date: DateModel
    var Time: TimeModel
    var seatNumber: String
    var boarding: String
    var destination: String
    var qr: UIImage?
}
