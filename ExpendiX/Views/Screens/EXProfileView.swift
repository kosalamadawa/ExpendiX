//
//  EXProfileView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import SwiftUI

struct EXProfileView: View {
    @StateObject var viewModel = EXProfileViewViewModel()
    
    var body: some View {
        VStack {
            Button {
                viewModel.logout()
            } label: {
                Text("Sign Out")
            }
        }
    }
}

struct EXProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EXProfileView()
    }
}
