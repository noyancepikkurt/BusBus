//
//  FindBusTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

class FindBusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var timeLabelCell: UILabel!
    @IBOutlet weak var timeLeftLabelCell: UILabel!
    @IBOutlet weak var priceLabelCell: UILabel!
    @IBOutlet weak var dateLabelCell: UILabel!
    @IBOutlet weak var boardingFromLabelCell: UILabel!
    @IBOutlet weak var destinationLabelCell: UILabel!
    
    func setup(_ ticketModel: FindBusModel) {
        imageViewCell.image = ticketModel.imageView
        timeLabelCell.text = ticketModel.timeLabel
        timeLeftLabelCell.text = ticketModel.timeLeftLabel
        priceLabelCell.text = "\(ticketModel.priceLabel ?? 0) ₺"
        dateLabelCell.text = ticketModel.dateLabel
        boardingFromLabelCell.text = ticketModel.boardingFromLabel
        destinationLabelCell.text = ticketModel.destinationLabel
    }
    
    
    
    
}
