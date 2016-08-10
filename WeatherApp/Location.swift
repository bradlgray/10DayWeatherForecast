//
//  Location.swift
//  WeatherApp
//
//  Created by Brad Gray on 8/9/16.
//  Copyright © 2016 Brad Gray. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() { }
    
     var latitude: Double!
     var longitude: Double!
}