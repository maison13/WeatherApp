//
//  ViewController.swift
//  WheatherApp
//
//  Created by Vovo on 10.05.2023.
//

import UIKit
enum Link {
    case weatherForecast
    var url: URL {
        switch self {
            
        case .weatherForecast:
            return URL(string: "https://api.open-meteo.com/v1/forecast?latitude=55.75&longitude=37.62&hourly=temperature_2m,weathercode,windspeed_10m,is_day&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,windspeed_10m_max&forecast_days=14&timezone=Europe%2FMoscow")!
        }
    }
    
}

final class MainViewController: UIViewController {
    
    @IBOutlet weak var dailyWeatherCV: UICollectionView!
    @IBOutlet weak var hourlyWeatherCV: UICollectionView!

    private let networkManager = NetworkManager.shared
    private var weatherData: Weather!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let hourlyCVC = segue.destination as? HourlyCollectionViewController else { return }
        hourlyCVC.weatherData = weatherData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        dailyWeatherCV.delegate = self
        dailyWeatherCV.dataSource = self
        
       
        // Создание UIImageView и добавление его на view
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "IOS_Walp2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
        // установка прозрачности фона
        dailyWeatherCV.backgroundColor = .clear
        
    }
        
    private func fetchWeatherData() {
        networkManager.fetch(Weather.self, url: Link.weatherForecast.url) { [weak self] result in
            switch result {
            case .success(let weather):
                print(weather)
                self?.weatherData = weather
                self?.dailyWeatherCV.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherData?.daily.time.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as! DailyCollectionViewCell
            cell.weatherImage.image = UIImage(named: "Rain")
            
       
            
            cell.dateLabel.text = weatherData?.daily.time[indexPath.item]
        
            // Восход
            let sunrise = weatherData.daily.sunrise[indexPath.item]
            let sunriseComponents = sunrise.split(separator: "T")
            let sunriseTime = String(sunriseComponents[1])
            // Закат
            let sunset = weatherData.daily.sunset[indexPath.item]
            let sunsetComponents = sunset.split(separator: "T")
            let sunsetTime = String(sunsetComponents[1])
            
            cell.weatherInfoLabel.text = """
            Скорость ветра: \(weatherData.daily.windspeedMax[indexPath.item])
            Температура: \(weatherData.daily.temperatureMax[indexPath.item])
            Восход: \(sunriseTime)
            Закат: \(sunsetTime)
            """
            
            return cell
        }
        
    }
    
