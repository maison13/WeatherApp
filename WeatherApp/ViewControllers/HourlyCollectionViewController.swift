//
//  HourlyCollectionViewController.swift
//  WeatherApp
//
//  Created by Vovo on 15.05.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class HourlyCollectionViewController: UICollectionViewController {
    
    var weatherData: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Создание UIImageView и добавление его на view
        let imageView = UIImageView(frame: collectionView.bounds)
        imageView.image = UIImage(named: "IOS_Walp3")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        collectionView.backgroundView = imageView
        
       // navigationController?.navigationBar.alpha = 0
       
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherData.hourly.time.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCollectionViewCell
        
      
        
        let hourlyInfo = weatherData.hourly.time[indexPath.item]
        let hourlyComponents = hourlyInfo.split(separator: "T")
        let hourlyDate = String(hourlyComponents[0])
        let hourlyTime = String(hourlyComponents[1])
        cell.hourlyDataInfo.text = """
        Дата: \(hourlyDate), время: \(hourlyTime).
        Температура: \(weatherData.hourly.temperature[indexPath.item]) °C, скорость ветра: \(weatherData.hourly.windspeed[indexPath.item]) км/ч.
        
        """
    
        return cell
    }

}
