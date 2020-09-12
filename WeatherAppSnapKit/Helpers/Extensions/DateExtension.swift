//
//  DateExtension.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation

extension Date {
    func getTodayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    func getDateWithTimeZone() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 3600 * 3) // the desired timezone
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        let newDate = formatter.string(from: self)
        return newDate
        
        //
      //  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
      //  let string2 = formatter.string(from: self)
       // print("GMT+3 format result: \(string2)")
    }
}
extension Int {
    func dateFormatTime(format:String="dd/MM/yyyy") -> String {
        let newTime = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr")
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 3)
        return dateFormatter.string(from: newTime)
    }
}
