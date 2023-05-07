//
//  WheatherTableViewController.swift
//  WheatherApp
//
//  Created by Vovo on 07.05.2023.
//

import UIKit

final class WheatherTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    private func fetchWeatherData() {
        let wheatherData: URL = URL(
            string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"
        )!
        URLSession.shared.dataTask(with: wheatherData) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let curentWheather = try decoder.decode(Wheather.self, from: data)
                print(curentWheather)
            } catch {
                print(error)
            }
          
        }.resume()
    }

}
