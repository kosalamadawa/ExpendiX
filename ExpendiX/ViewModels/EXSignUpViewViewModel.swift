//
//  EXSignUpViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXSignUpViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isRegistering = false
    @Published var errorMessage = ""
    
    init() {}
    
    func register() {
        isRegistering = true
        guard validate() else {
            isRegistering = false
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid, error == nil, let strongSelf = self else {
                return
            }
            strongSelf.insertUserRecord(id: userId)
            strongSelf.isRegistering = false
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = EXUser(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password should contains at least 6 characters"
            return false
        }
        return true
    }
}
