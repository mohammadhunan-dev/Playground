//
//  ContentView.swift
//  FunctionsPlayground
//
//  Created by Dominic Frei on 13/01/2021.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    let app = App(id: "functions-gjsvg")
    @MongoCallable<Foo> var foo
    
    var body: some View {
        Text("\(foo.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
