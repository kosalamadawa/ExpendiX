//
//  EXHomeView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXHomeView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Home")
                .tabItem {
                    Image(selection == 0 ? "homeSelected" : "home")
                    Text("Home")
                }
                .tag(0)
            EXProfileView()
                .tabItem {
                    Image(selection == 1 ? "userSelected" : "user")
                    Text("Profile")
                }
                .tag(1)
        }
        .tint(Color("ColorAccent"))
    }
}

struct EXHomeView_Previews: PreviewProvider {
    static var previews: some View {
        EXHomeView()
    }
}
