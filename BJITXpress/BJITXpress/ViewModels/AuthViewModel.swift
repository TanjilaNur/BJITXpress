//
//  AuthViewModel.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation

class AuthViewModel: NSObject, ObservableObject{
    
    // public static var shared = AuthManager()
    @Published public var empName = ""
    @Published public var empId = ""
    public var employee: Employee?
    // @Published var employee: Employee?
     
    func getUserData() -> AppState{
        // logout()
        let empName = UserDefaults.standard.value(forKey: "EMP_NAME") as? String
        let empId = UserDefaults.standard.value(forKey: "EMP_ID") as? String
        guard let empName = empName,
              let empId = empId else {
            print("DEBUG: Failed to register!")
            return .showLoginView
        }
        self.employee = Employee(empName: empName, empId: empId)
        return .noInput
    }
    
    func login(empName: String, empId: String) -> AppState {
        if empName == "" && empId == "" {
            return .showLoginView
        }
        UserDefaults.standard.setValue(empName, forKey: "EMP_NAME")
        UserDefaults.standard.setValue(empId, forKey: "EMP_ID")
        UserDefaults.standard.synchronize()
        
        self.employee = Employee(empName: empName, empId: empId)
        return .noInput
    }
    
    func isLoggedIn(){
        
    }
    
    func logout() -> AppState{
        UserDefaults.standard.setValue(nil, forKey: "EMP_NAME")
        UserDefaults.standard.setValue(nil, forKey: "EMP_ID")
        UserDefaults.standard.synchronize()

        return .showLoginView
    }

    
}
