//
//  FindBusTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

final class FindBusTableViewCell: UITableViewCell {
    @IBOutlet private weak var imageViewCell: UIImageView!
    @IBOutlet private weak var timeLabelCell: UILabel!
    @IBOutlet private weak var timeLeftLabelCell: UILabel!
    @IBOutlet private weak var priceLabelCell: UILabel!
    @IBOutlet private weak var dateLabelCell: UILabel!
    @IBOutlet private weak var boardingFromLabelCell: UILabel!
    @IBOutlet private weak var destinationLabelCell: UILabel!
    
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
