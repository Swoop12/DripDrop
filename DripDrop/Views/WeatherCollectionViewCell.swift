//
//  WeatherCollectionViewCell.swift
//  DripDrop
//
//  Created by DevMountain on 9/8/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    var dailyWeather: DailyWeather?{
        didSet{
            updateView()
        }
    }
    
    func stringFromTime(time: TimeInterval) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        let date = Date(timeIntervalSince1970: time)
        
        return formatter.string(from: date)
    }
    
    func updateView(){
        guard let dailyWeather = dailyWeather else {return}
        
        summaryLabel.text = dailyWeather.summary
        dayOfTheWeekLabel.text = stringFromTime(time: dailyWeather.time)
        iconImageView.image = UIImage(named: dailyWeather.icon) ?? UIImage(named: "cloudy")!
        iconImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        iconImageView.layer.shadowRadius = 2.0
        iconImageView.layer.shadowOpacity = 0.8
        tempLabel.text = "\(Int(dailyWeather.temperatureMax + dailyWeather.temperatureMin)/2) Degrees"
    }
}
