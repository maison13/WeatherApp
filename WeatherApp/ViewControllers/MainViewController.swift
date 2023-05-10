//
//  ViewController.swift
//  WheatherApp
//
//  Created by Vovo on 10.05.2023.
//

import UIKit

final class MainViewController: UIViewController {
  
    @IBOutlet weak var curentWeatherLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    private var weatherData: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()

    }
    
    
    private func fetchWeatherData() {
        let weatherData: URL = URL(
            string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"
        )!
        networkManager.fetchWeatherData(from: weatherData) { [weak self] result in
            switch result {
            case .success(let weather):
                print(weather)
                self?.weatherData = weather
                self?.curentWeatherLabel.text = """
                    Время измерения: \(weather.current_weather.time )
                    Текущая температура: \(weather.current_weather.temperature) С
                    Текущая скорость ветра: \(weather.current_weather.windspeed) м/с
                    """
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let weatherTableVC = segue.destination as? WeatherTableViewController else { return }
        weatherTableVC.weatherData = weatherData
    }
}
