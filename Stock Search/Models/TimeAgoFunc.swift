//
//  TimeAgoFunc.swift
//  Stock Search
//
//  Created by 陈冲 on 12/2/20.
//

import Foundation

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

func getTimeAgoStr(preDateStr: String) -> String {
    // preDateStr e.g. 2020-11-04T14:01:01Z

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    let timeZone = TimeZone(identifier: "America/Los_Angeles")!
    dateFormatter.timeZone = timeZone
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    let preDate: Date = dateFormatter.date(from:preDateStr)!
    let currDate: Date = Date()
    
    let days: Int = currDate.days(from: preDate)
    let hours: Int = currDate.hours(from: preDate)
    let minutes: Int = currDate.minutes(from: preDate)
    
    if (minutes < 60) {
        return "\(minutes)min ago"
    } else if (hours < 24) {
        return "\(hours)h ago"
    } else {
        return "\(days) days ago"
    }
}
