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
        //        Realm.Configuration.defaultConfiguration = Realm.Configuration(encryptionKey: Data(count: 64))
        let realm = try! Realm()
        try! realm.write {
            realm.add(TestObject())
        }
        
        //        for _ in 0..<30000 {
        //            try! realm.write {
        //                realm.add(TestObject())
        //            }
        //        }
        
        var array = [TestObject]()
        for _ in 0..<30000 {
            array.append(TestObject())
        }
        try! realm.write {
            realm.add(array)
        }
        
        print(realm.objects(TestObject.self).count)
        // 30k writes with 1 object encrypted: 1.1 GB
        // 1 write with 30k objects encrypted: 3.3 MB
        // 30k writes with 1 object unencrypted: 8.3 MB
        // 1 write with 30k objects unencrypted: 7.3 MB
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
