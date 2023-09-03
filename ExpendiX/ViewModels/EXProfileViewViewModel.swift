//
//  EXProfileViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import Foundation
import FirebaseAuth

final class EXProfileViewViewModel: ObservableObject {
    init() {}
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
