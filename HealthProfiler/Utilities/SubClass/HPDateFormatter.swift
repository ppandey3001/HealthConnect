//
//  HPDateFormatter.swift
//  HealthProfiler
//

import Foundation

public enum DateFormatType: String {
    
    case API_DateTime = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
    case API_DateTime_noTimeZone    = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
    case timeOnly  = "hh:mm a" //05:06 pm
    case date = "MMM dd, yyyy" //Aug 19, 2017
    case day = "dd" //19
    case month = "MMM" //Aug
    case dateTime = "MMM-dd-YYYY, hh:mm a" //Dec-02-2017 05:06 pm

    
    /*
    case profileHireDate = "yyyy-MM-dd"
    case ui_dob = "MMM, dd" //Dec, 02
    case ui_monthDay = "MMM dd" //Dec 02
    case ui_dateTime = "dd MMMM yyyy, h:mm a" //24 June 2017, 5:06pm
    case ui_date = "MMM dd, yyyy" //Aug 19, 2017
    case ui_timeOnly = "h:mm a" //5:30 am
    case ui_dateOnly = "dd" //19
    case ui_weekDay = "EEEE" //19
    case ui_monthOnly = "MMM" //Aug
    case ui_modifiedDate = "dd/MM/yyyy"
    case ui_eventEndDateTime = "h:mm a EEE MMMM dd, yyyy" //10 am Fri aug 15, 2017
    case ui_eventHeader = "EEE dd MMM, yyyy" //Wed 14 Aug, 2017
    case ui_contentRead = "MMMM dd, yyyy 'at' h:mm a" //June 24, 2017 at 5:06pm
    case ui_eventStartTime = "EEE MMM dd, h:mm a" //Wed Jun 24, 5:06pm
    case ui_albumPublishedTime = "EEE MMM dd, yyyy" //Wed Aug 19, 2017
    case ui_fileDetailTime = "MMM dd, yyyy, h:mma" //May 05, 2017, 4:36pm
    case ui_commentCreatedTime = "MMM dd, yyyy 'at' h:mma" //Oct 18, 2017 at 5:06pm

    case ET_DateTime = "yyyy-MM-dd hh:mm:ss"

    case ui_bannerEventStartTime = "EEE MMM dd, yyyy, h:mm a" //Wed Jun 24, 2019, 5:06pm
    case ui_eventStartTime_timeline = "EEE MMM dd" //Wed Jun 24
     */
}

//DATE FORMATTER
public class HPDateFormatter: DateFormatter {
    
    public static let shared = HPDateFormatter()
    
    public func getDate(from dateString: String, format: DateFormatType) -> Date? {
        
        dateFormat = format.rawValue
        return date(from: dateString)
    }
    
    public func getString(from date: Date, format: DateFormatType) -> String {
        
        dateFormat = format.rawValue
        return string(from: date)
    }
}

