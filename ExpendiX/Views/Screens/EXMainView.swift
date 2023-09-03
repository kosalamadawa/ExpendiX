//
//  EXMainView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import SwiftUI

struct EXMainView: View {
    @StateObject var viewModel = EXMainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            EXHomeView()
        } else {
            EXLoginView()
        }
    }
}

struct EXMainView_Previews: PreviewProvider {
    static var previews: some View {
        EXMainView()
    }
}
