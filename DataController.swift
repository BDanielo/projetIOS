//
//  DataController.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BaseDeDonnees")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Erreur de chargement du Data Model")
            }
        }
    }
}
