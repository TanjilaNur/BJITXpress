//
//  EmpAllocatorViewModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation
import CloudKit
import SwiftUI

enum RecordType: String{
    // case arrivalTable = "arrival_history"
    case arrivalTable = "CD_ARRIVAL_HISTORY"
}

class EmpAllocatorViewModel: NSObject, ObservableObject{
    private var database: CKDatabase
    public var container: CKContainer
    let busCapacity = 10
    var busTimestamp = [BusType.bus1.busTimestamp, BusType.bus2.busTimestamp, BusType.bus3.busTimestamp, BusType.bus4.busTimestamp]
    @Published var empArrivalData: [EmpDataModel] {
        didSet{
            print(empArrivalData)
        }
    }

    override init(){
        self.container = CKContainer(identifier: "iCloud.tryCatch.bjitgroup.upskilldev")
        // self.container = CKContainer(identifier: "iCloud.com.shamin.cloudKitStarterQ3") //com.shamin.cloudKitStarterQ3
        self.database = self.container.publicCloudDatabase
        self.empArrivalData = []
        super.init()
    }
    
    func saveItem(emp_name: String, emp_id: String, arrival_time: Int, arrival_timestamp: Double, completion: @escaping (AppState)->()){
        let arrival_timestamp = Date().getTimestampAfterInterval(timestamp: arrival_timestamp, minutes: arrival_time)
        allocateBus(emp_id: emp_id, arrival_timestamp: arrival_timestamp){
            result, isAlreadyReserved in
            if isAlreadyReserved {
                completion(AppState.alreadyReserved)
            }
            else {
                switch result{
                    case .success(let allocatedBusId):
                        if allocatedBusId == 0{
                            completion(AppState.reservationFailure)
                        }
                        else {
                            let empRecord = EmpRecordModel(emp_name: emp_name,
                                                   emp_id: emp_id,
                                                   arrival_time: arrival_time,
                                                   arrival_timestamp: arrival_timestamp,
                                                   bus_id: allocatedBusId)
                            self.saveEmpRecord(empRecord: empRecord){
                                appState in
                                completion(appState)
                            }
                        }
                    
                case .failure(let error):
                    print("DEBUG: [EmpAllocatorViewModel.saveItem] \(error.localizedDescription)")
                        completion(AppState.reservationSuccess)
                }
            }

        }
    }
    /*
      Takes emloyee list and try to allocate a bus id to a user.
    */
    private func allocateBus(emp_id: String, arrival_timestamp: Double, completion: @escaping (Result<Int, Error>, Bool)->Void){
        getData(){
            result in
            switch result{
                case .success(let employeeList):
                    var flag = false
                    var empDataTmp: EmpRecordModel?
                    for empData in employeeList {
                        if empData.emp_id == emp_id {
                            flag = true
                            empDataTmp = empData
                        }
                    }
                    if flag && empDataTmp !=  nil {
                        completion(.success(empDataTmp!.bus_id), true)
                    }
                    else{
                        let allocatedBus = self.allocateEmployee(arrival_timestamp: arrival_timestamp, employeeList: employeeList)
                        completion(.success(allocatedBus), false)
                    }
                case .failure(let error):
                    print("DEBUG: [EmpAllocatorViewModel.allocateBus] \(error.localizedDescription)")
                    completion(.failure(error), false)
            }
        }
    }
    
    /*
      After allocating a bus to a user save the record to the cloudkit public db.
    */
    func saveEmpRecord(empRecord: EmpRecordModel, completion: @escaping (AppState)->()){
        let record = CKRecord(recordType: RecordType.arrivalTable.rawValue)
        record.setValuesForKeys(empRecord.toDictionary())
        self.database.save(record){ newRecord, error in
            if let error = error {
                print("DEBUG: [EmpAllocatorViewModel.saveEmpRecord] \(error.localizedDescription)")
                completion(.reservationFailure)
            }
            else {
                if let newRecord = newRecord {
                    if let employeeListing = EmpRecordModel.fromRecord(newRecord){
                        DispatchQueue.main.async {
                            self.empArrivalData.append(EmpDataModel(employeeListing: employeeListing))
                            // print(self.empArrivalData)
                        }
                    }
                }
                completion(.reservationSuccess)
            }
        }
    }
    
    /*
      Find a free bus within the users arrival timestamp and return the bus id.
      If can not be allocated then return 0.
    */
    func allocateEmployee(arrival_timestamp: Double, employeeList: [EmpRecordModel]) -> Int {
        var buses: [[EmpRecordModel]] = [[], [], [], []]
        for emp in employeeList {
            guard emp.bus_id > 0 && emp.bus_id <= 4 else {
                continue
            }
            buses[emp.bus_id - 1].append(emp)
        }
        for (index, bus) in buses.enumerated() {
            if arrival_timestamp <= busTimestamp[index] && bus.count < busCapacity {
                return index + 1
            }
        }
        return 0
    }
    /*
      Fetch employee arrival data from cloudkit.
    */
    func getData(completion: @escaping (Result<[EmpRecordModel], Error>)->Void){
        let predicate = NSPredicate(format: "arrival_timestamp >= %f", Date.getTodaysTimeStamp())
        let query = CKQuery(recordType: RecordType.arrivalTable.rawValue, predicate: predicate)
        var _items: [EmpRecordModel] = []
        database.fetch(withQuery: query){
            result in
            switch result {
            case .success(let data):
                data.matchResults.compactMap{$0.1} // returns tuple
                    .forEach{ // foreach that tuple
                        switch $0{
                            case .success(let record):
                                if let empArrivalHistory = EmpRecordModel.fromRecord(record){
                                    _items.append(empArrivalHistory)
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                completion(.success(_items))
            case .failure(let error):
                print("DEBUG: [EmpAllocatorViewModel.getData] \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func populateItems(){
        self.getData(){
            result in
            switch result{
                case .success(let employeeList):
                    for empData in employeeList {
                        self.empArrivalData.append(EmpDataModel(employeeListing: empData))
                    }
                    print("DEBUG: [EmpAllocatorViewModel.populateItems]: ")
                    print("\(self.empArrivalData)")
                case .failure(let error):
                    print("DEBUG: [EmpAllocatorViewModel.populateItems] Failure to fetch employee allocation data \(error.localizedDescription)")
            }
        }
    }
    
    func deleteItem(_ indexSet: IndexSet){
        indexSet.forEach{
            index in
            let item = empArrivalData[index]
            if let recordId = item.recordId{
                deleteItem(recordId)
            }
        }
    }

    func deleteItem(_ recordId: CKRecord.ID){
        database.delete(withRecordID: recordId){
            deletedRecord, error in
            if let error = error {
                print("DEBUG: [EmpAllocatorViewModel.deleteItem] Error in delation \(error.localizedDescription)")
            }
            else{
                // print("DEBUG: [EmpAllocatorViewModel.deleteItem] Deleted item: ")
                // print(deletedRecord)
                self.populateItems()
            }
        }
    }
    
}
