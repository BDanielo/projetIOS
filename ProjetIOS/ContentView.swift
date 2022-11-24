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
            VueDepot()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Depots")
                }
            VueCategorie()
                .tabItem {
                    Image(systemName: "square.split.2x2")
                    Text("Categories")
            }
            VueArticle()
                .tabItem {
                    Image(systemName: "cube.box.fill")
                    Text("Articles")
            }
        }.myTabViewStyle()

        
        
        
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
