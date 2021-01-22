//
//  ContentView.swift
//  PlaygroundApp
//
//  Created by Dominic Frei on 22/01/2021.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    init() {
        Playground.execute()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
