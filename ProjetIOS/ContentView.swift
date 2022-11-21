//
//  ContentView.swift
//  ProjetIOS
//
//  Created by Daniel Armieux on 21/11/2022.
//

import SwiftUI

struct VueDepots: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Depots>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomDepotChoisi: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Liste des depots")
                    .padding()
                List {
                    ForEach(Requete) { Depots in
                        HStack {
                            Text(Depots.nom ?? "").foregroundColor(.gray)
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
        let nouveauDepot = Depots(context: Element)
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

struct VueCategories: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Categories>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomCategorieChoisie: String = ""
    @State var descCategorieChoisie: String = ""
    
    @State var statutErreur: Bool = false
    @State var messageErreur: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Liste des categories")
                    .padding()
                List {
                    ForEach(Requete) { Categories in
                        HStack {
                            Text(Categories.nom ?? "")
                            Text(Categories.desc ?? "").foregroundColor(.gray)
                        }
                    }.onDelete(perform: supprimerCategorie)
                }
                TextField("Nom de la categorie", text:$nomCategorieChoisie).multilineTextAlignment(.center)
                TextField("Description de la categorie", text:$descCategorieChoisie).multilineTextAlignment(.center)
                Button("+ Nouvelle categorie") {
                    nouvelleCategorie()
                }
                
            }.alert(isPresented: $statutErreur) {
                Alert(
                    title: Text("Erreur"),
                    message: Text(messageErreur)
                )
            }.padding()
        }.navigationTitle("Liste des categories").navigationBarTitleDisplayMode(.inline)
    }
    
    func nouvelleCategorie() {
        let nomChoisi = nomCategorieChoisie
        let descChoisie = descCategorieChoisie
        if (!nomChoisi.isEmpty) {
            let nouvelleCategorie = Categories(context: Element)
            nouvelleCategorie.id = UUID()
            nouvelleCategorie.nom = "\(nomChoisi)"
            nouvelleCategorie.desc = "\(descChoisie)"
            try? Element.save()
        }
        else {
            statutErreur=true
            messageErreur="Le nom de la categorie ne peut etre vide"
        }
    }
    
    func supprimerCategorie(at offsets: IndexSet) {
        for offset in offsets {
        let categorieChoisie = Requete[offset]
        Element.delete(categorieChoisie)
        }
        try? Element.save()
        }
}

struct VueArticles: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Articles>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomArticleChoisi: String = ""
    @State var descArticleChoisi: String = ""
    @State var qteArticleChoisi: String = "0"
    
    @State var statutErreur: Bool = false
    @State var messageErreur: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Liste des articles")
                    .padding()
                List {
                    ForEach(Requete) { Articles in
                        HStack {
                            Text(Articles.nom ?? "")
                            Text(Articles.desc ?? "")
                            Text(String(Articles.qte)).padding(.horizontal, 20)
                        }
                    }.onDelete(perform: supprimerArticle)
                }
                TextField("Nom de l'article", text:$nomArticleChoisi).multilineTextAlignment(.center)
                TextField("Description de l'article", text:$descArticleChoisi).multilineTextAlignment(.center)
                TextField("Quantite de l'article", text:$qteArticleChoisi).multilineTextAlignment(.center)
                Button("+ Ajouter l'article") {
                    ajoutArticle()
                }
                
            }.alert(isPresented: $statutErreur) {
                Alert(
                    title: Text("Erreur"),
                    message: Text(messageErreur)
                )
            }.padding()
        }.navigationTitle("Liste des articles").navigationBarTitleDisplayMode(.inline)
    }
    
    func ajoutArticle() {
        let nomChoisi = nomArticleChoisi
        let descChoisi = descArticleChoisi
        if (!nomChoisi.isEmpty) {
        let qteChoisi : Int16 = Int16(qteArticleChoisi) ?? 0
        let article = Articles(context: Element)
        article.id = UUID()
        article.nom = "\(nomChoisi)"
        article.desc = "\(descChoisi)"
        article.qte = qteChoisi
        try? Element.save()
        }
        else {
            statutErreur=true
            messageErreur="Le nom de l'article ne doit pas etre vide"
        }
    }
    
    func supprimerArticle(at offsets: IndexSet) {
        for offset in offsets {
        let articleChoisi = Requete[offset]
        Element.delete(articleChoisi)
        }
        try? Element.save()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VueCategories()
    }
}

