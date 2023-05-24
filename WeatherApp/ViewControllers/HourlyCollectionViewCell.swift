//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Vovo on 15.05.2023.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyDataInfo: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
    }
}
