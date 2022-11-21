//
//  ContentView.swift
//  ProjetIOS
//
//  Created by Hugo Bourgey on 21/11/2022.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}




struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("Reflexo")
                    HStack {
                        NavigationLink (destination: VueDepot()) {
                         Text ("Dépôts")
                         .padding(10)
                         .foregroundColor(.green)
                        }
                        NavigationLink (destination: VueCategorie()) {
                            Text ("Catégories")
                            .padding(10)
                            .foregroundColor(.green)
                        }
                        NavigationLink (destination: VueArticle()) {
                         Text ("Articles")
                         .padding(10)
                         .foregroundColor(.green)
                        }
                    }
                    .frame(width: UIScreen.screenWidth ,alignment: .top)
                    .listStyle(PlainListStyle())
                }
                .background(Color.pink)
                .frame(alignment: .top)
                
                Text("Hello, world!")
                    .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .background(Color.yellow)
        }
        .frame(alignment: .top)
        
        
        
    }
}

struct VueDepot: View {
    var body: some View {
        Text("Dépots")
    }
}

struct VueCategorie: View {
    var body: some View {
        Text("Catégories")
    }
}

struct VueArticle: View {
    var body: some View {
        Text("Articles")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
