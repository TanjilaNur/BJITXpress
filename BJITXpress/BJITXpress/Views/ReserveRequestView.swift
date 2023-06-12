//  
//  ReserveRequestView.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import SwiftUI
import CloudKit

struct ReserveRequestView: View {
    @Binding var appState: AppState
    @EnvironmentObject var locationViewModel: UserLocationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var empAllocVM: EmpAllocatorViewModel
    
    var body: some View{
       VStack{
           Capsule()
               .foregroundColor(Color(.systemGray5))
               .frame(width: 48, height: 6)
               .padding(.top, 8)
           HStack{
               VStack{
                   Circle()
                       .fill(Color(.systemGray3))
                       .frame(width: 8, height: 8)
                   Rectangle()
                       .frame(width: 1, height: 32)
                   Circle()
                       .fill(.black)
                       .frame(width: 8, height: 8)
               }
            VStack(alignment: .leading, spacing: 24){
                HStack{
                   Text("Current Location")
                       .font(.system(size: 16, weight: .semibold))
                       .foregroundColor(.gray)
                   Spacer()
                   Text(locationViewModel.startTime ?? "")
                       .font(.system(size: 16))
                       .foregroundColor(.gray)

                }.padding(.bottom, 10)
                HStack{
                    if let destLocation = locationViewModel.selectedLocation?.title {
                           Text(destLocation)
                               .font(.system(size: 16, weight: .semibold))
                    }
                    Spacer()
                    Text(locationViewModel.arrivalTime ?? "")
                           .font(.system(size: 16, weight: .semibold))
                }
              }
           }
           .padding()
           Divider()
           
           if appState == .requestReservation {
               Text("Loading...")
           }
           else {
               Button{
                  print("DEBUG: [ReserveRequestView.body.Button] Confirm reservation!")
                   if let employee = authViewModel.employee,
                      let timeToReach = locationViewModel.timeToReach{
                       empAllocVM.saveItem(emp_name: employee.empName,
                                           emp_id: employee.empId,
                                           arrival_time: Int(timeToReach)/60,
                                           arrival_timestamp: Date().getTimestamp()){
                           state in
                           appState = state
                       }
                   }
                   
               } label: {
                   Text("Confirm Reservation")
                       .font(.subheadline.bold())
                       .frame(width: 180, height: 40, alignment: .center)
                       .background(.cyan)
                       .opacity(0.9)
                       .foregroundColor(.white)
                       .cornerRadius(18)
               }
           }
           
       }
       .padding(.bottom, 50)
       .background(.white)
       .cornerRadius(34)
    }
}

struct ReserveRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ReserveRequestView(appState: .constant(.reservationSuccess))
    }
}
