//
//  DateTimeUtility.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation

func getTimestampFromDate(date : Date) -> Double
{
    return date.timeIntervalSince1970
}

func currentTimeInMilliSeconds()-> Int
{
    let currentDate = Date()
    let since1970 = currentDate.timeIntervalSince1970
    return Int(since1970 * 1000)
}

func getDateFromTimeStamp(_ timeStemp:Double) -> Date
{
    return Date(timeIntervalSince1970: TimeInterval(timeStemp/1000))
}

func getLocalDateStringFromDate(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDateStringFromServerTimeStemp(_ timeStemp:Double) -> String {
    
    let date : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMM yyyy"//DATE_FORMAT.DISPLAY_DATE_FORMAT
    return dateFormatter.string(from: date)
}

func convertToUTC(dateToConvert:String) -> String {
     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
     let convertedDate = formatter.date(from: dateToConvert)
     formatter.timeZone = TimeZone(identifier: "UTC")
     return formatter.string(from: convertedDate!)
}

func getDateFromDateString(strDate : String) -> Date    // Today, 09:56 AM
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let dt = dateFormatter.date(from: strDate)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date1 : String = dateFormatter.string(from: dt ?? Date())
    return dateFormatter.date(from: date1)!
}

func getDateFromDateString(strDate : String, format : String) -> Date?
{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current //TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: strDate)
}

func getDateStringFromDate(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
//    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDateStringFromDate1(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current //TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDateStringFromDateString(strDate : String, formate: String) -> String    // Today, 09:56 AM
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = formate
    return dateFormatter1.string(from: date1)
}

func getTimeStringFromDateString1(strDate : String) -> String    // 09:56 AM
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = "HH:mm a"
    return dateFormatter1.string(from: date1)
}

func getDateInCurrentTimeZone(date: String, outGoingFormat: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = outGoingFormat
    return dateFormatter.date(from: date)!
}

func localToUTC1(date: String, outGoingFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = outGoingFormat
    let dt = dateFormatter.date(from: date)!
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    return dateFormatter.string(from: dt)
}

//MARK: Date difference
func getDifferenceFromCurrentTime(_ timeStemp : Double) -> Int
{
    let newDate : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    let currentDate : Date = getCurrentDate()
    let interval = currentDate.timeIntervalSince(newDate)
    return Int(interval)
}

func getCurrentDate() -> Date
{
    let currentDate : Date = Date()
    return currentDate
}

func getDifferenceFromCurrentTimeInHourInDays(_ newDate : String) -> String
{
    let date = getDateFromDateString(strDate: newDate)
    let interval = Date().timeIntervalSince(date)
    
    let second : Int = Int(interval)
    let minutes : Int = Int(interval/60)
    let hours : Int = Int(interval/(60*60))
    let days : Int = Int(interval/(60*60*24))
    let week : Int = Int(interval/(60*60*24*7))
    let months : Int = Int(interval/(60*60*24*30))
    let years : Int = Int(interval/(60*60*24*30*12))
    
    var timeAgo : String = ""
        if hours < 24
        {
            timeAgo = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE3.getValue())
        }
        else{
            timeAgo = getDateStringFromDate(date: date, format: DATE_FORMMATE.DATE7.getValue())
        }
    return timeAgo
}

//func getDifferenceFromCurrentTimeInHourInDays(_ newDate : String) -> String
//{
//    let date = getDateFromDateString(strDate: newDate)
//    let interval = Date().timeIntervalSince(date)
//
//    let second : Int = Int(interval)
//    let minutes : Int = Int(interval/60)
//    let hours : Int = Int(interval/(60*60))
//    let days : Int = Int(interval/(60*60*24))
//    let week : Int = Int(interval/(60*60*24*7))
//    let months : Int = Int(interval/(60*60*24*30))
//    let years : Int = Int(interval/(60*60*24*30*12))
//
//    var timeAgo : String = ""
//        if  second < 60
//        {
//            timeAgo = "In 0 minutes" //(second < 3) ? "Just Now" : (String(second) + "s")
//        }
//        else if minutes < 60
//        {
//            timeAgo = String(minutes) + " minutes ago"
//        }
//        else if hours < 24
//        {
//            timeAgo = String(hours) + "hr ago"//" hour ago"
//        }
//        else if days < 10
//        {
//            timeAgo = String(days) + " "  + ((days > 1) ? "days ago" : "day ago")
//        }
//        else{
//            timeAgo = getDateStringFromDate(date: date, format: "dd MMM yyyy")
//        }
////    else if week < 4
////    {
////        timeAgo = String(week) + " "  + ((week > 1) ? "weeks" : "week")
////    }
////    else if months < 12
////    {
////        timeAgo = String(months) + " "  + ((months > 1) ? "months" : "month")
////    }
////    else
////    {
////        timeAgo = String(years) + " "  + ((years > 1) ? "years" : "year")
////    }
//
////    if second > 3 {
////        timeAgo = timeAgo + " ago"
////    }
//    return timeAgo
//}

extension String {
  //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
    
  //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
}
