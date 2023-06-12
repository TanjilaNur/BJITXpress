//  
//  AppStateActionButton.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import SwiftUI

struct AppStateActionButton: View {
    @Binding var appState: AppState
    @EnvironmentObject var locationVM: UserLocationViewModel
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(appState)
            }
        } label: {
            Image(systemName: "arrow.left")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .padding(.leading, 15)
                .padding(.top, 15)
                // .shadow(color: Color.black, radius: 6)
        }
        .frame(minWidth: UIScreen.main.bounds.width, alignment: .leading)
    }
    func actionForState(_ state: AppState){
        switch state{
        case .requestReservation,
                .polyLineAdded,
                .reservationSuccess,
                .reservationFailure:
                print("DEBUG: [MapViewActionButton.actionForState] Clear map view and back to reservation view.")
                appState = .noInput
            default:
                print("DEBUG: [MapViewActionButton.actionForState] No input")
        }
    }

}

struct AppStateActionButton_Previews: PreviewProvider {
    static var previews: some View {
        AppStateActionButton(appState: .constant(.noInput))
    }
}
