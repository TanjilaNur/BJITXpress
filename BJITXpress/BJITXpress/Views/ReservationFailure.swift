//
//  ReservationFailure.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 17/5/23.
//

import SwiftUI

struct ReservationFailure: View {
    @Binding var appState: AppState
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            HStack{
                VStack{
                    Image("failure")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
             VStack(alignment: .leading, spacing: 24){
                 HStack{
                    Text("Failed to reserve bus for you! Please try again.")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                    Spacer()

                 }.padding(.bottom, 10)
               }
            }
            .padding()
            Divider()
            Button{
               print("DEBUG: [ReserveFailureView.body.Button] Failed to reserve!")
                appState = .noInput                    
            } label: {
                Text("Retry")
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

struct ReservationFailure_Previews: PreviewProvider {
    static var previews: some View {
        ReservationFailure(appState: .constant(AppState.reservationFailure))
    }
}
