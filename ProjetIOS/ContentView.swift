//
//  ContentView.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Liste des depots")
                    .padding()
            }
        }.navigationTitle("Liste des depots").navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

