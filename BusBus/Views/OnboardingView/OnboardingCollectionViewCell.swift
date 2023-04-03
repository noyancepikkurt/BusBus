//
//  OnboardingCollectionViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingDetail: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        onboardingImage.image = slide.image
        onboardingDetail.text = slide.detail
    }
}
