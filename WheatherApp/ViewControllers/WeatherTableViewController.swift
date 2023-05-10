//
//  WheatherTableViewController.swift
//  WheatherApp
//
//  Created by Vovo on 07.05.2023.
//

import UIKit

final class WeatherTableViewController: UITableViewController {
    
    var weatherData: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let textLabel = UILabel()
        textLabel.text = "История погоды"
        textLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        textLabel.textAlignment = .center
        navigationItem.titleView = textLabel
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.hourly.temperature_2m.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let temperature = weatherData.hourly.temperature_2m[indexPath.row]
        let time = weatherData.hourly.time[indexPath.row]
        content.text = "Дата измерений \(time)"
        content.secondaryText = "Температура \(String(temperature))"
        cell.contentConfiguration = content
        return cell
    }
    
   

}
