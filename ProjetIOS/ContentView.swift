//
//  ContentView.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


extension TabView {

    func myTabViewStyle() -> some View {
        self.background(Color(UIColor.systemGray6))
    }
}


struct ContentView: View {
    init() {
        UITabBar.appearance().isTranslucent = false
    }
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack{
            Text("Reflexo")
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .top).background(Color(UIColor.systemBlue))
        
        TabView {
            VueDepots()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Depots")
                }
//            VueCategorie()
//                .tabItem {
//                    Image(systemName: "square.split.2x2")
//                    Text("Categories")
//            }
//            VueArticle()
//                .tabItem {
//                    Image(systemName: "cube.box.fill")
//                    Text("Articles")
//            }
        }.myTabViewStyle()
    }
}

struct VueDepots: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Depots>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomDepotChoisi: String = ""
    
    @State var afficherNouveauDepot = false
    
    @State var statutErreur: Bool = false
    @State var messageErreur: String = ""
    
    var body: some View {
            VStack{
                HStack{
                    Text("Liste des depots")
                    Button("+"){
                        afficherNouveauDepot.toggle()
                    }
                }
                if afficherNouveauDepot {
                HStack{
                    TextField("Nom du nouveau depot", text:$nomDepotChoisi).multilineTextAlignment(.leading).padding(6)
                    Button("Ajouter le depot") {
                        nouveauDepot()
                    }.padding(6)
                }
                }
                List {
                    ForEach(Requete) { Depots in
                        HStack {
                            Text(Depots.nom ?? "")
                        }
                    }.onDelete(perform: supprimerDepot)
                }

                
            }.alert(isPresented: $statutErreur) {
                Alert(
                    title: Text("Erreur"),
                    message: Text(messageErreur)
                )
            }
    }
    
    func nouveauDepot() {
        let nomChoisi = nomDepotChoisi
        if (!nomChoisi.isEmpty) {
        let nouveauDepot = Depots(context: Element)
        nouveauDepot.id = UUID()
        nouveauDepot.nom = "\(nomChoisi)"
        try? Element.save()
        } else {
            statutErreur=true
            messageErreur="Le nom du depot ne peut etre vide"
        }
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

