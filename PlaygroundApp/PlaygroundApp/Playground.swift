//
//  Playground.swift
//  PlaygroundApp
//
//  Created by Dominic Frei on 22/01/2021.
//

import Foundation
import RealmSwift

class IntObject: Object {
    @objc dynamic var id: Int = 0
}

class StringObject: Object {
    @objc dynamic var string: String = ""
}

struct Playground {
    
    static func execute() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            let stringObject1 = StringObject(value: ["string": "depressão"])
            let stringObject2 = StringObject(value: ["string": "depressao"])
            realm.add([stringObject1, stringObject2])
        }
        let results1 = realm.objects(StringObject.self).filter("string CONTAINS 'press'")
        print(results1)
        assert(results1.count == 2)
        
        let results2 = realm.objects(StringObject.self).filter("string CONTAINS 'ao'")
        print(results2)
        assert(results2.count == 1)
        
        let results3 = realm.objects(StringObject.self).filter("string CONTAINS 'ão'")
        print(results3)
        assert(results3.count == 1)
        
        let results4 = realm.objects(StringObject.self).filter("string CONTAINS[cd] 'ao'")
        print(results4)
        assert(results4.count == 2)
    }
    
}
