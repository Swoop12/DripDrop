//
//  WeatherViewController.swift
//  DripDrop
//
//  Created by DevMountain on 9/8/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempuratureLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    var currentLocation: CLLocation?{
        didSet{
            fetchWeather()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherController.shared.dailyWeathers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell
        let dailyWeather = WeatherController.shared.dailyWeathers?[indexPath.row]
        cell?.dailyWeather = dailyWeather
        return cell ?? UICollectionViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        
        
    WeatherController.shared.locatioinManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            WeatherController.shared.locatioinManager.delegate = self
            WeatherController.shared.locatioinManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            WeatherController.shared.locatioinManager.startUpdatingLocation()
        }
    }
    
    func updateCurrentWeather(){
        cityLabel.text = "Salt Lake City"
        summaryLabel.text = WeatherController.shared.currentWeather?.summary
        tempuratureLabel.text = "\(Int(WeatherController.shared.currentWeather?.temperature ?? 0))°"
    }
    
    func fetchWeather(){
        
        
        guard let latitude = currentLocation?.coordinate.latitude,
            let longitude = currentLocation?.coordinate.longitude else {return}
        
        WeatherController.shared.fetchWeeklyWeather(latitude: latitude, longitude: longitude) { (_) in
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
                self.updateCurrentWeather()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
}
