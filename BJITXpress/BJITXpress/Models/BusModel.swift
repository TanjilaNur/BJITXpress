//
//  BusModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation

enum BusType: Int, CaseIterable, Identifiable {
    case bus1
    case bus2
    case bus3
    case bus4
    var id: Int {return rawValue}
    var description : String {
        switch self {
            case .bus1: return "Bus 1 (7:20AM)"
            case .bus2: return "Bus 2 (7:30AM)"
            case .bus3: return "Bus 3 (7:40AM)"
            case .bus4: return "Bus 4 (7:50AM)"
        }
    }
    
    var capacity: Double {
        switch self {
            case .bus1: return 50
            case .bus2: return 50
            case .bus3: return 50
            case .bus4: return 50
        }
    }
        
    var busTimestamp: Double {
        let calendar = Calendar.current
        let now = Date()
        switch self {
        case .bus1:
            var time = DateComponents()
            time.hour = 7
            time.minute = 20
            let date = calendar.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: now)!
            var timeInterval = date.timeIntervalSince1970
            print(timeInterval)
            return timeInterval
        case .bus2:
            var time = DateComponents()
            time.hour = 7
            time.minute = 30
            let date = calendar.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: now)!
            var timeInterval = date.timeIntervalSince1970
            print(timeInterval)
            return timeInterval
        case .bus3:
            var time = DateComponents()
            time.hour = 7
            time.minute = 40
            let date = calendar.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: now)!
            var timeInterval = date.timeIntervalSince1970
            print(timeInterval)
            return timeInterval
        case .bus4:
            var time = DateComponents()
            time.hour = 7
            time.minute = 50
            let date = calendar.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: now)!
            var timeInterval = date.timeIntervalSince1970
            print(timeInterval)
            return timeInterval
        }
    }
    
     
}

/*
class BusModel{
    var busId: Int
    var capacity: Int
    var avaliableSeats: Int
    var busTimestamp: Double
    var employees: [EmpDataModel]
    
    init(busId: Int, capacity: Int, avaliableSeats: Int, busTimestamp: Double, employees: [EmpDataModel] = []){
        self.busId = busId
        self.capacity = busId
        self.avaliableSeats = avaliableSeats
        self.busTimestamp = busTimestamp
        self.employees = employees
    }
}
*/
