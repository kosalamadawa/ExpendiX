//
//  LoginView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXLoginView: View {
    @StateObject var viewModel = EXLoginViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                EXHeaderView(title: "Login")
                Spacer()
                    .frame(height: 24)
                EXTextFieldView(placeholder: "Email", value: $viewModel.email)
                EXTextFieldView(placeholder: "Password", value: $viewModel.password, type: .Secure)
                
                EXButtonView(text: "Login", isLoading: viewModel.isLogginIn) {
                    viewModel.login()
                }
                
                if !viewModel.errorMessage.isEmpty {
                    EXErrorMessage(message: "Please fill in all details")
                }
                
                HStack(spacing: 4) {
                    Text("Don’t have an account yet?")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("ColorLight20"))
                    NavigationLink(destination: EXSignUpView()) {
                        Text("Sign Up")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color("ColorAccent"))
                        .underline()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden()
        }
    }
}

struct EXLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EXLoginView()
    }
}
