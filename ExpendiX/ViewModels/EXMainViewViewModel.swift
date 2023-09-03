//
//  EXMainViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import Foundation
import FirebaseAuth

final class EXMainViewViewModel: ObservableObject {
    @Published var currentUserId = ""
    private var authHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.authHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
