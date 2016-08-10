//
//  ViewController.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/4/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var hiTempArray = [Double]()
    var lowTempArray = [Double]()
    var weatherConditionArray = [String]()
    var weatherConditionArrayImg = [String]()
    var dayOfWeekArray = [String]()
    
    var currentWeather = CurrentWeather()
    var WeatherForecast = weatherForecast()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!

    @IBOutlet weak var Today: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherConditions: UIImageView!
    @IBOutlet weak var weatherConditionsLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getLocation()
        //        WeatherForecast.getWeatherForecast {
//            self.updateDailyUIWeather()
//            self.tableView.reloadData()
////            print("high temp \(self.WeatherForecast.hiTempArray)")
////            print("low temp \(self.WeatherForecast.lowTempArray)")
////            print("current Condition \(self.WeatherForecast.weatherCondition)")
////            print("current Day \(self.WeatherForecast.dayOfWeek)")
//            
//        }
    
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func getLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    }
    
    func locationAuthStatus()  {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            WeatherForecast.getWeatherForecast {
                self.updateDailyUIWeather()
                self.tableView.reloadData()
                
            }
            currentWeather.DownloadCurrentWeather() {
                self.updateMainUIWeather()
                
            }

            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell") as? WeatherViewCell {
            let highCell = hiTempArray[indexPath.row]
            let lowCell = lowTempArray[indexPath.row]
            let weatherCondition = weatherConditionArray[indexPath.row]
            let weatherConditionImg = weatherConditionArrayImg[indexPath.row]
            let dayOfWeek = dayOfWeekArray[indexPath.row]
            print("high \(highCell)")
            print(lowCell)
            
            cell.configureCell(highCell, LowTemp: lowCell, WeatherCondition: weatherCondition, WeatherConditionImg: weatherConditionImg, currentDay: dayOfWeek)
            
            return cell
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherForecast.hiTempArray.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func updateMainUIWeather() {
        self.tempLabel.text = "\(self.currentWeather.currentTemp)"
        self.Today.text = self.currentWeather.Date
        self.cityLabel.text = self.currentWeather.City
        self.weatherConditionsLbl.text = self.currentWeather.weatherCondition
        self.weatherConditions.image = UIImage(named: self.currentWeather.weatherCondition)
    }

    func updateDailyUIWeather() {
        hiTempArray.appendContentsOf(WeatherForecast.hiTempArray)
        lowTempArray.appendContentsOf(WeatherForecast.lowTempArray)
        weatherConditionArray.appendContentsOf(WeatherForecast.weatherCondition)
        weatherConditionArrayImg.appendContentsOf(WeatherForecast.weatherCondition)
        dayOfWeekArray.appendContentsOf(WeatherForecast.dayOfWeek)
    }
  
    
}

