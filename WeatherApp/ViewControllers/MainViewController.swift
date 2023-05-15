//
//  ViewController.swift
//  WheatherApp
//
//  Created by Vovo on 10.05.2023.
//

import UIKit
enum Link {
    case weatherForecast
    case weatherIcon
    var url: URL {
        switch self {
            
        case .weatherForecast:
            return URL(string: "https://api.open-meteo.com/v1/forecast?latitude=55.75&longitude=37.62&hourly=temperature_2m,relativehumidity_2m,rain,weathercode,et0_fao_evapotranspiration,windspeed_10m,winddirection_10m,is_day&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,windspeed_10m_max&timezone=Europe%2FMoscow")!
        case .weatherIcon:
            return URL(string: "https://gist.githubusercontent.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c/raw/db92e194f4f2109a68a706e46bc624eb3cbe3889/descriptions.json")!
        }
    }
    
}

final class MainViewController: UIViewController {
    
    @IBOutlet weak var dailyWeatherCV: UICollectionView!
    @IBOutlet weak var hourlyWeatherCV: UICollectionView!

    private let networkManager = NetworkManager.shared
    private var weatherData: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        dailyWeatherCV.delegate = self
        dailyWeatherCV.dataSource = self
        hourlyWeatherCV.delegate = self
        hourlyWeatherCV.dataSource = self
       
       
       
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
        switch collectionView {
        case dailyWeatherCV:
            return weatherData?.daily.time.count ?? 0
        default:
            return weatherData?.hourly.time.count ?? 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case dailyWeatherCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as! DailyCollectionViewCell
            cell.dateLabel.text = weatherData?.daily.time[indexPath.item]
            cell.weatherImage.image  = UIImage(named: "like")
            // Восход
            let sunrise = weatherData.daily.sunrise[indexPath.item]
            let sunriseComponents = sunrise.split(separator: "T")
            let sunriseTime = String(sunriseComponents[1])
            // Закат
            let sunset = weatherData.daily.sunset[indexPath.item]
            let sunsetComponents = sunrise.split(separator: "T")
            let sunsetTime = String(sunsetComponents[1])
            
            cell.weatherInfoLabel.text = """
            Скорость ветра: \(weatherData.daily.windspeedMax[indexPath.item])
            Температура: \(weatherData.daily.temperatureMax[indexPath.item])
            Восход: \(sunriseTime)
            Закат: \(sunsetTime)
            """
            
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCollectionViewCell
            
            return cell
        }
        
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
}
