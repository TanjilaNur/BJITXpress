//
//  BusAllocationView.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 16/5/23.
//  

import SwiftUI

struct BusAllocationView: View {
    @Binding var appState: AppState
    @EnvironmentObject private var empAllocVM: EmpAllocatorViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)

            HStack(alignment: .center){
                Text("ID")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)

                Spacer()
                Text("Name")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)

                Spacer()
                Text("Bus")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)

            }.padding(.top, 5)
            Divider()
            ScrollView(showsIndicators: false){
                ForEach(empAllocVM.empArrivalData, id: \.recordId){
                    item in
                    // var savedName = UserDefaults.value(forKey: "EMP_NAME")
                    // var savedId = UserDefaults.value(forKey: "EMP_ID")
                    if item.emp_name == "Kazi" && item.emp_id == "Kazi" {
                        Divider()
                            .foregroundColor(Color.red)
                    }
                        
                    HStack(alignment: .center){
                        Text(item.emp_id)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)
                        
                        Spacer()
                        Text(item.emp_name)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)
                        Spacer()
                        Text(String(describing: item.bus_id))
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .frame(width: UIScreen.main.bounds.width / 3, alignment: .center)
                    }
                    .frame(height: 40)
                    Divider()
                }.background(Color.white)
            }
            .onAppear{
                empAllocVM.populateItems()
            }
            .background(Color.white)
        }
        .frame(height: 300)
        .padding(15)
        .background(.white)
        .cornerRadius(60)
        
    }
}

/*
struct BusAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        BusAllocationView(appState: .constant(AppState.reservationSuccess), authState: .constant(.showLoginView))
    }
}
*/
