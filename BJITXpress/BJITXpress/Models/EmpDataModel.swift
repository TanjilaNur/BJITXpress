//
//  EmpDataModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation
import CloudKit

/*
 EmpDataModel is used for the data that are associated with view.
*/

struct EmpDataModel {
    let employeeListing: EmpRecordModel
    
    var recordId: CKRecord.ID?{
        employeeListing.recordId
    }
    
    var emp_name: String{
        employeeListing.emp_name
    }

    var emp_id: String{
        employeeListing.emp_id
    }
    
    var arrival_time: Int{
        employeeListing.arrival_time
    }
    
    var arrival_timestamp: Double{
        employeeListing.arrival_timestamp
    }
    
    var bus_id: Int{
        employeeListing.bus_id
    }
}
