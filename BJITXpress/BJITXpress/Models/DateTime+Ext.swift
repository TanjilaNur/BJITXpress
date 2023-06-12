//
//  DateTime+Ext.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation

extension Date{
    /*
    func getDateTimeAfter(minutes: Int){
        let currentDate = Date()
        let minutesToAdd = 30
        _ = currentDate.addingTimeInterval(TimeInterval(minutesToAdd * 60))
    }
    Apr 28, 2023 at 11:28:16 AM 1682659696.978817
    Apr 28, 2023 at 11:18:49 AM 1682659129.908211
    Apr 28, 2023 at 11:38:16 AM 1682660296.978817

    Date().getDateFromTimestamp()
    Date().getDateFromTimestamp(timestamp: 1682659129.908211)

    var tinmestmp = Date().getTimestampAfterInterval(timestamp: 1682659696.978817, minutes: 10)
    Date().getDateFromTimestamp(timestamp: tinmestmp)
    */
    
    // Date().description(with: .current)
    
    func getDateFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        // dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }

    func getTimestamp() -> Double {
        return self.timeIntervalSince1970
    }
    
    func getTimestampAfterInterval(minutes: Int) -> Double{
        let currentTimestamp = self.timeIntervalSince1970
        let timestampAfterInterval = currentTimestamp + Double((minutes * 60))
        return timestampAfterInterval
    }
    
    func getTimestampAfterInterval(timestamp: Double, minutes: Int) -> Double{
        let timestampAfterInterval = timestamp + Double((minutes * 60))
        return timestampAfterInterval
    }
    
    func getDateFromTimestamp() -> String {
        // Apr 28, 2023 at 11:18:49 AM 1682659129.908211
        let timestamp = getTimestamp()
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = getDateFormatter()
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    func getDate()->String{
        let dateFormatter = getDateFormatter()
        return dateFormatter.string(from: Date())
    }
    
    func getDateFromTimestamp(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = getDateFormatter()
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }

    func getTimestampfromDate(date: String) -> Double{
        let dateFormatter = getDateFormatter()
        let date = dateFormatter.date(from: date)!
        let timestamp = date.timeIntervalSince1970
        // Date(timeIntervalSince1970: TimeInterval(timestamp))
        return timestamp
    }
    
    func getMinutesDifferenceFromTwoDates(start: Date, end: Date) -> Int {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        return minutes
    }
    
    
    func getSimulatorTime() -> Date? {
        // Check if the code is running in the simulator
        #if targetEnvironment(simulator)
            if let environment = ProcessInfo.processInfo.environment["SIMULATOR_FIXED_DATE"] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                
                // Convert the simulator's fixed date to a Date object
                if let fixedDate = dateFormatter.date(from: environment) {
                    return fixedDate
                }
            }
        #endif
        
        // Return nil if not running in the simulator or if the fixed date is not available
        return nil
    }
    
    
    static func getCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: Date())
    }
    
    static func getTodaysTimeStamp() -> Double{
        var time = DateComponents()
        time.hour = 0
        time.minute = 0
        let date = Calendar.current.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: Date())!
        return date.timeIntervalSince1970
    }


    
}




