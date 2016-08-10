//
//  Constants.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/4/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let APIKEY = "f0f8b9bccaa20cfff29aa7b2e630f019"



let URLWeatherBase = "http://api.openweathermap.org/data/2.5/weather?"
let URLWeatherForecastBase = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let Lat = "lat="
let Long = "&lon="
let appId = "&appid="
let cnt = "&cnt=10&mode=json&appid="

let weatherURL = "\(URLWeatherBase)\(Lat)\(Location.sharedInstance.latitude)\(Long)\(Location.sharedInstance.longitude)\(appId)\(APIKEY)"
let dailyForecast = "\(URLWeatherForecastBase)\(Lat)\(Location.sharedInstance.latitude)\(Long)\(Location.sharedInstance.longitude)\(cnt)\(APIKEY)"



