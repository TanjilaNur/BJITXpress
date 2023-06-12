//
//  HomeView.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var locationViewModel: UserLocationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var empAllocViewModel: EmpAllocatorViewModel
    @State var appState: AppState = .showLoginView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top){
                MapViewRepresentable(appState: $appState)
                    .ignoresSafeArea()
                if appState == .requestReservation ||
                    appState == .polyLineAdded ||
                    appState == .reservationSuccess ||
                    appState == .reservationFailure{
                    AppStateActionButton(appState: $appState)
                }
            }
            if appState == .noInput {
                ReserveActionButton(appState: $appState)
                    .transition(.move(edge: .bottom))
                    .opacity(0.90)
            }
            else if appState == .requestReservation || appState == .polyLineAdded{
                ReserveRequestView(appState: $appState)
                    .opacity(0.90)
            }
            else if appState == .reservationFailure {
                ReservationFailure(appState: $appState)
                    .transition(.move(edge: .bottom))
                    .opacity(0.90)
            }
            else if appState == .requestReservation {
                ShowLoadingIndicator()
            }
            else if appState == .reservationSuccess {
                BusAllocationView(appState: $appState)
                    .transition(.move(edge: .bottom))
            }
            else if appState == .showLoginView {
                LoginView(appState: $appState)
                    .opacity(0.90)
                    .transition(.move(edge: .bottom))
            }
            else if appState == .alreadyReserved {
                AlreadyReservedView(appState: $appState)
                    .opacity(0.90)
                    .transition(.move(edge: .bottom))
            }


        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(){
            // print("hello")
        }
         
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
