//
//  EmpRecordModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation
import CloudKit

struct EmpRecordModel {
    var recordId: CKRecord.ID?
    let emp_name: String
    let emp_id: String
    let arrival_time: Int // time takes to arrive
    let arrival_timestamp: Double //timestamp
    let bus_id: Int // allocated bus
    
    init(recordId: CKRecord.ID? = nil, emp_name: String, emp_id: String, arrival_time: Int, arrival_timestamp: Double, bus_id: Int){
        self.recordId = recordId
        self.emp_name = emp_name
        self.emp_id = emp_id
        self.arrival_time = arrival_time
        self.arrival_timestamp = arrival_timestamp
        self.bus_id = bus_id
    }
        
    static func fromRecord(_ record: CKRecord) -> EmpRecordModel?{
        guard
              let emp_name = record.value(forKey: "emp_name") as? String,
              let emp_id = record.value(forKey: "emp_id") as? String,
              let arrival_time = record.value(forKey: "arrival_time") as? Int,
              let arrival_timestamp = record.value(forKey: "arrival_timestamp") as? Double,
              let bus_id = record.value(forKey: "bus_id") as? Int else {
            return nil
        }
        return EmpRecordModel(recordId: record.recordID, emp_name: emp_name, emp_id: emp_id, arrival_time: Int(arrival_time), arrival_timestamp: arrival_timestamp, bus_id: Int(bus_id))
    }
    
    func toEmpRecordModel() -> EmpDataModel{
        return EmpDataModel(employeeListing: self)
    }
    
    
    func toDictionary() -> [String: Any]{
        return ["emp_name": self.emp_name, "emp_id": self.emp_id, "arrival_time": self.arrival_time, "arrival_timestamp": self.arrival_timestamp, "bus_id": self.bus_id]
    }
    
    
}
