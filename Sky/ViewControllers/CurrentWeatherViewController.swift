//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Vassily on 2018/7/3.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    var weatherData: WeatherData? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    var location: Location? {
        didSet { DispatchQueue.main.async { self.updateView() } }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }
    
    private func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let weatherData = weatherData, let location = location {
            self.updateWeatherContainer(at: location, with: weatherData)
        } else {
            loadingFailedLabel.text = "Cannot load fetch weather/location data from the network."
            loadingFailedLabel.isHidden = false
        }
    }

    private func updateWeatherContainer(at location: Location, with data: WeatherData) {
        weatherContainerView.isHidden = false
        
        // 1. Set location
        locationLabel.text = location.name
        
        // 2. Format and set temperature
        temperatureLabel.text = String(
            format: "%.1f °C",
            data.currently.temperature.toCelcius())
        
        // 3. Set weather icon
        weatherIcon.image = weatherIcon(
            of: data.currently.icon)
        
        // 4. Format and set humidity
        humidityLabel.text = String(
            format: "%.1f",
            data.currently.humidity)
        
        // 5. Set weather summary
        summaryLabel.text = data.currently.summary
        
        // 6. Format and set datetime
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(
            from: data.currently.time)
    }
}