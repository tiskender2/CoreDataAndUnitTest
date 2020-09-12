//
//  StringExtension.swift
//  WeatherAppwithSnapKit
//
//  Created by Tolga İskender on 9.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func kelvinToCelcius() -> String {
        let c = String(format: "%.0f", self - 273.15)
        let celcius = "\(c)°C"
        return celcius
    }
}
