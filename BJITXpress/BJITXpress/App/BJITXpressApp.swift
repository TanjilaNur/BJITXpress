//
//  BJITXpressApp.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import SwiftUI
import CloudKit

@main
struct BJITXpressApp: App {
    @StateObject private var locationViewModel = UserLocationViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var empAllocViewModel = EmpAllocatorViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(authViewModel)
                .environmentObject(empAllocViewModel)
        }
    }
}
