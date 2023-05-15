//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Vovo on 15.05.2023.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
   
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
}
