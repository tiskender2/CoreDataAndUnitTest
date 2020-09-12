//
//  EndPoint.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation

enum EndPoint:String {
    case weather
}
enum BaseURL:String {
    case scheme = "https"
    case host = "api.openweathermap.org"
    case path = "/data/2.5/"
}
