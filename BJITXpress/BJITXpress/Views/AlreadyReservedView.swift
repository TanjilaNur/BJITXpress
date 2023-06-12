//
//  AlreadyReservedView.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 18/5/23.
//

import SwiftUI

struct AlreadyReservedView: View {
    @Binding var appState: AppState
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            HStack{
                VStack{
                    Image("yellow-alert")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
             VStack(alignment: .leading, spacing: 24){
                 HStack{
                    Text("Already reserved for today.")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                    Spacer()

                 }.padding(.bottom, 10)
               }
            }
            .padding()
            Divider()
            Button{
                print("DEBUG: [ReserveFailureView.body.Button] Already reserved!")
                appState = .reservationSuccess
            } label: {
                Text("Show reservation")
                    .font(.subheadline.bold())
                    .frame(width: 180, height: 40, alignment: .center)
                    .background(.cyan)
                    .opacity(0.9)
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }
        }
        .padding(.bottom, 50)
        .background(.white)
        .cornerRadius(34)

    }
}
struct AlreadyReservedView_Previews: PreviewProvider {
    static var previews: some View {
        AlreadyReservedView(appState: .constant(.alreadyReserved))
    }
}
