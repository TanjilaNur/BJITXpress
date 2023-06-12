//  
//  ReserveActionButton.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import Foundation
import SwiftUI

struct ReserveActionButton: View {
    @Binding var appState: AppState
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            Image("school-bus-vector-illustration")
                .resizable()
                .frame(width: 140, height: 100, alignment: .center)
            
            Text("There are four busses from  7:20-7:50 AM and each of the capacity of 50.")
                .padding(.bottom, 5)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .multilineTextAlignment(.center)
                .frame(width: 400)
                .foregroundColor(.gray)
            
            Text("Let's book BJITXpress with just one tap!")
                .multilineTextAlignment(.center)
                .frame(width: 400)
                .foregroundColor(.black)
                .padding(.bottom, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)

            Button{
                withAnimation(.spring()){
                    appState = .requestReservation
                }
            } label: {
                Text("Reserve now")
                    .font(.subheadline.bold())
                    .frame(width: 180, height: 40, alignment: .center)
                    .background(.cyan)
                    .opacity(0.9)
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }
            .padding(.bottom, 30)
        }
        .padding(.bottom, 40)
        .background(.white)
        .cornerRadius(60)

    }
}

struct ReserveActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ReserveActionButton(appState: .constant(.noInput))
    }
}
