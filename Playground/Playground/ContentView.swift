//
//  ContentView.swift
//  Playground
//
//  Created by Dominic Frei on 25/02/2021.
//

import SwiftUI
import RealmSwift

class TestObject: Object {
    @objc dynamic var foo = 42
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(encryptionKey: Data(count: 64))
        let realm = try! Realm()
        for _ in 0..<30000 {
            try! realm.write {
                realm.add(TestObject())
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
