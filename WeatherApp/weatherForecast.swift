//
//  weatherForecast.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/8/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class weatherForecast {
    private var _hiTempArray = [Double]()
    private var _lowTempArray = [Double]()
    private var _weatherCondition = [String]()
    private var _weatherConditionImg = [String]()
    private var _dayOfWeek = [String]()
    
    
    var weatherCondition: [String] {
        get {
             return _weatherCondition
        }
        set {
            _weatherCondition = newValue
        }
       
    }
    var weatherConditionImg: [String] {
        get {
             return _weatherConditionImg
        }
        set {
            _weatherConditionImg = newValue
        }
    }
    
    var dayOfWeek: [String] {
        get {
             return _dayOfWeek
        }
        set {
            _dayOfWeek = newValue
        }
        
    }
    var hiTempArray: [Double] {
        
        return _hiTempArray
    }
    var lowTempArray: [Double] {
        return _lowTempArray
    }
    
    func getWeatherForecast(completed: DownloadComplete) {
        Alamofire.request(.GET, dailyForecast).responseJSON { response in
            switch response.result {
            case .Success:
                if let result = response.result.value {
                    let json = JSON(result)
                    
                    
                    if let list = json["list"].array {
                        for lists in list {

                            
                            if let maxTemp = lists["temp"]["max"].double {
                                if let minTemp = lists["temp"]["min"].double {
                                    
                                    let kevlinPreDivisionMax = (maxTemp * (9/5) - 459.67)
                                    let kelvinToFarenheitMax = Double(round(10 * kevlinPreDivisionMax/10))
                                    
                                    let kelvinPreDivisionMin = (minTemp * (9/5) - 459.67)
                                    let kelvinToDivisionMin = Double(round(10 * kelvinPreDivisionMin/10))
                                        
                                    self._lowTempArray.append(kelvinToDivisionMin)
                                    
                                    self._hiTempArray.append(kelvinToFarenheitMax)
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    if let list = json["list"].array {
                        for lists in list {
                            if let condition = lists["weather"][0]["main"].string {
                                
                            self.weatherCondition.append(condition)
                            }
                        }
                    }
                    
                    if let day = json["list"].array {
                        for days in day {
                            if let exactDay = days["dt"].double {
                                let unixConvertedDate = NSDate(timeIntervalSince1970: exactDay)
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateStyle = .FullStyle
                                dateFormatter.dateFormat = "EEEE"
                                dateFormatter.timeStyle = .NoStyle
                                let datish = unixConvertedDate.dayOfTheWeek()
                                
                                self._dayOfWeek.append(datish)
                                
                            }
                        }
                    }
                    
                   
                }
            case.Failure:
                print("Error")
                    }
                
            completed()
            }
        
        }
    
    
    }
extension NSDate {
    func dayOfTheWeek() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(self)
    }
}

    