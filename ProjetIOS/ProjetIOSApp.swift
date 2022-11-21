//
//  ProjetIOSApp.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import SwiftUI

@main
struct ProjetIOSApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            VueDepots().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
