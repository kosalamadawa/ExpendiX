//
//  EXLoginViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import Foundation
import FirebaseAuth

final class EXLoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogginIn = false
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        isLogginIn = true
        guard validate() else {
            isLogginIn = false
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.isLogginIn = false
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        return true
    }
}
