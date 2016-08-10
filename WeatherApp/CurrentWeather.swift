//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/4/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    

private var _hiTemp: Double!
private var _lowTemp: Double!
private var _City: String!
private var _currentTemp: Double!
private var _weatherCondition: String!
private var _Date: String!

var hiTemp: Double {
    if _hiTemp == nil {
        _hiTemp = 0.0
    }
return _hiTemp
}

var lowTemp: Double {
    if _lowTemp == nil {
        _lowTemp = 0.0
    }
return _lowTemp
}

var City: String {
    if _City == nil {
        _City = ""
    }
    
return _City
}

var currentTemp: Double {
    if _currentTemp == nil {
        _currentTemp = 0.0
    }
    
return _currentTemp
    
    }

var weatherCondition: String {
    if _weatherCondition == nil {
        _weatherCondition = ""
    }
return _weatherCondition
}

var Date: String {
    
    if _Date == nil {
        _Date = ""
    }
   
    
            let date = NSDate()
            let dateFormater = NSDateFormatter()
            dateFormater.dateStyle = .LongStyle
            dateFormater.timeStyle = .NoStyle
    
            let currentDate = dateFormater.stringFromDate(date)
    
    
            _Date = "Today \(currentDate)"

    
    
return _Date
}
    func ConvertKelvinToFahrenheit(Kelvin: Double) -> Double {
       let kevlinPreDivision = (Kelvin * (9/5) - 459.67)
        let kelvinToFarenheit = Double(round(10 * kevlinPreDivision/10))
        return kelvinToFarenheit
    }
    
    func DownloadCurrentWeather(completed: DownloadComplete) {
        
        Alamofire.request(.GET, weatherURL).responseJSON  { response in
            switch response.result {
            case .Success:
                if let result = response.result.value {
                    let json = JSON(result)
                    
                    
                    
                    let temp = json["main"]["temp"].double
                    self._currentTemp = self.ConvertKelvinToFahrenheit(temp!)
                    
                    self._weatherCondition = json["weather"][0]["main"].string
                    
                    self._City = json["name"].string
                   
                    
                    
                    
                }
                
                
            case .Failure:
                print("failure")
            }
          completed()
        }
        
    }
    
    
    
    
}

