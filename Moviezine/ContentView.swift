//
//  ContentView.swift
//  Moviezine
//
//  Created by Aditya Tyagi  on 31/01/22.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        
            NavigationView {
                MovieHomeView()
                  }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
