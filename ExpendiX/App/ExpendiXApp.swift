//
//  ExpendiXApp.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI
import FirebaseCore

@main
struct ExpendiXApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EXMainView()
        }
    }
}
