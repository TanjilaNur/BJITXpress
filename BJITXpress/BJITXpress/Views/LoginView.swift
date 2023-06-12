//
//  LoginView.swift
//  BJITXpress
//
//  Created by Kazi Omar Faruk on 15/5/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var appState: AppState
    var body: some View {
        ZStack {
                VStack {
                    VStack{
                        Image("school-bus-vector-illustration")
                            .resizable()
                            .frame(width: 140,
                                   height: 100,
                                   alignment: .center)
                    }
                    VStack{
                        Text("Sign In")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .kerning(1.9)
                            .frame(maxWidth: .infinity,
                                   alignment: .center)
                        VStack{
                            TextField("Employee name", text: $authViewModel.empName)
                                .font(.system(size: 14))
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                                .disableAutocorrection(true)
                            Divider()
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        VStack{
                            TextField("Employee ID", text: $authViewModel.empId)
                                .font(.system(size: 14))
                                .cornerRadius(10)
                                .foregroundColor(Color.black)
                                .disableAutocorrection(true)
                            Divider()
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                    Button{
                        let appStateTemp = authViewModel.login(
                            empName: authViewModel.empName,
                            empId: authViewModel.empId)
                        withAnimation(.easeInOut(duration: 0.5)) {
                                appState = appStateTemp
                        }
                    } label: {
                        Text("Login")
                            .font(.subheadline.bold())
                            .frame(width: 180, height: 30, alignment: .center)
                            .background(.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(18)
                        
                    }.padding(.bottom, 30)
                }
            }
        .frame(height: 330)
        .background(.white)
        .cornerRadius(24)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appState: .constant(.showLoginView))
    }
}
