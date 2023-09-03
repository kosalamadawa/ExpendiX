//
//  EXSignUpView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXSignUpView: View {
    @StateObject var viewModel = EXSignUpViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                EXHeaderView(title: "Sign Up")
                Spacer()
                    .frame(height: 24)
                ScrollView() {
                    VStack(spacing: 24) {
                        EXTextFieldView(placeholder: "Name", value: $viewModel.name)
                        EXTextFieldView(placeholder: "Email", value: $viewModel.email)
                        EXTextFieldView(placeholder: "Password", value: $viewModel.password, type: .Secure)
                        EXButtonView(text: "Sign Up", isLoading: viewModel.isRegistering) {
                            viewModel.register()
                        }
                        
                        if !viewModel.errorMessage.isEmpty {
                            EXErrorMessage(message: "Please fill in all details")
                        }
                        
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("ColorLight20"))
                            NavigationLink(destination: EXLoginView()) {
                                Text("Login")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color("ColorAccent"))
                                .underline()
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden()
        }
    }
}

struct EXSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EXSignUpView()
    }
}
