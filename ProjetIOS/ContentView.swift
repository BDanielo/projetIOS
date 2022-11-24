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
            //            VueDepots()
            //                .tabItem {
            //                    Image(systemName: "house.fill")
            //                    Text("Depots")
            //                }
            //            VueCategorie()
            //                .tabItem {
            //                    Image(systemName: "square.split.2x2")
            //                    Text("Categories")
            //            }
            VueArticles()
                .tabItem {
                    Image(systemName: "cube.box.fill")
                    Text("Articles")
                }
        }.myTabViewStyle()
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
        ContentView()
    }
}

