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
            VueCategories()
                .tabItem {
                    Image(systemName: "square.split.2x2")
                    Text("Categories")
            }
            VueArticles()
                .tabItem {
                    Image(systemName: "cube.box.fill")
                    Text("Articles")
            }
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

struct VueCategories: View {
    
    @FetchRequest(sortDescriptors: []) var Requete: FetchedResults<Categories>
    @Environment(\.managedObjectContext) var Element
    
    @State var nomCategorieChoisie: String = ""
    @State var descCategorieChoisie: String = ""
    
    @State var statutErreur: Bool = false
    @State var messageErreur: String = ""
    
    @State var afficherNouvelleCategorie = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Liste des categories")
                Button("+"){
                    afficherNouvelleCategorie.toggle()
                }
            }
            if afficherNouvelleCategorie {
                VStack{
                    TextField("Nom de la categorie", text:$nomCategorieChoisie).multilineTextAlignment(.center)
                    TextField("Description de la categorie", text:$descCategorieChoisie).multilineTextAlignment(.center)
                    Button("Ajouter la categorie") {
                        nouvelleCategorie()
                    }
                }}
            List {
                ForEach(Requete) { Categories in
                    HStack {
                        Text(Categories.nom ?? "")
                        Text(Categories.desc ?? "").foregroundColor(.gray)
                    }
                }.onDelete(perform: supprimerCategorie)
            }
            
            
        }.alert(isPresented: $statutErreur) {
            Alert(
                title: Text("Erreur"),
                message: Text(messageErreur)
            )
        }
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
    @State var qteArticleChoisi: String = ""
    
    @State var statutErreur: Bool = false
    @State var messageErreur: String = ""
    
    @State var afficherNouvelArticle = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Liste des articles")
                Button("+"){
                    afficherNouvelArticle.toggle()
                }
            }
            if afficherNouvelArticle {
                VStack{
                    TextField("Nom de l'article", text:$nomArticleChoisi).multilineTextAlignment(.center)
                    TextField("Description de l'article", text:$descArticleChoisi).multilineTextAlignment(.center)
                    TextField("Quantite de l'article", text:$qteArticleChoisi).multilineTextAlignment(.center)
                    Button("Ajouter l'article") {
                        ajoutArticle()
                    }
                }
            }
            List {
                HStack {
                    Text("Nom")
                    Text("Qte")
                }
                ForEach(Requete) { Articles in
                    HStack {
                        Text(Articles.nom ?? "")
                        Text(String(Articles.qte))
                        Button("Plus d'infos") {
                            //! lien a faire avec article pour la modif et afficher les infos
                        }
                    }
                }.onDelete(perform: supprimerArticle)
            }
            
            
        }.alert(isPresented: $statutErreur) {
            Alert(
                title: Text("Erreur"),
                message: Text(messageErreur)
            )
        }
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
        VueDepots()
    }
}

