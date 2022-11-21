//
//  ContentView.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import SwiftUI

struct VueDepots: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Depot>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomDepotChoisi: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Liste des depots")
                    .padding()
                List {
                    ForEach(Requete) { Depot in
                        HStack {
                            Text(Depot.nom ?? "").foregroundColor(.gray)
                        }
                    }.onDelete(perform: supprimerDepot)
                }
                TextField("Nom du nouveau depot", text:$nomDepotChoisi).multilineTextAlignment(.center)
                Button("+ Nouveau Depot") {
                    nouveauDepot()
                }
                
            }
        }.navigationTitle("Liste des depots").navigationBarTitleDisplayMode(.inline)
    }
    
    func nouveauDepot() {
        let nomChoisi = nomDepotChoisi
        let nouveauDepot = Depot(context: Element)
        nouveauDepot.id = UUID()
        nouveauDepot.nom = "\(nomChoisi)"
        try? Element.save()
    }
    
    func supprimerDepot(at offsets: IndexSet) {
        for offset in offsets {
        let depotChoisi = Requete[offset]
        Element.delete(depotChoisi)
        }
        try? Element.save()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VueDepots()
    }
}

