//
//  TicketModel.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import Foundation

class TicketModel {
    let passenger: [PassengerModel]?
    let Date: [DateModel]?
    let Time: [TimeModel]?
    let seat: String?
    let seatNumber: Int?
    
    init(passenger: [PassengerModel]?, Date: [DateModel]?, Time: [TimeModel]?, seat: String?, seatNumber: Int?) {
        self.passenger = passenger
        self.Date = Date
        self.Time = Time
        self.seat = seat
        self.seatNumber = seatNumber
    }
}
