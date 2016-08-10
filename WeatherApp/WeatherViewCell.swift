//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/8/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import UIKit

class WeatherViewCell: UITableViewCell {

    @IBOutlet weak var HiTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weatherConditionImg: UIImageView!
    @IBOutlet weak var currentDay: UILabel!
    
    func configureCell(hiTemp: Double, LowTemp: Double, WeatherCondition: String, WeatherConditionImg: String, currentDay: String) {
        HiTemp.text = String(hiTemp)
        self.lowTemp.text = String(LowTemp)
        self.weatherCondition.text = String(WeatherCondition)
        self.weatherConditionImg.image = UIImage(named: WeatherCondition)
        self.currentDay.text = currentDay
        
    }
    
    
}
