//
//  SelectSeatCollectionViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class SelectSeatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewForSelection: UIView!
    @IBOutlet weak var seatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UIView(frame: bounds)
        self.backgroundView = view
        let coloredView = UIView(frame: bounds)
        coloredView.backgroundColor = UIColor.red
        self.selectedBackgroundView = coloredView
    }
    
}
