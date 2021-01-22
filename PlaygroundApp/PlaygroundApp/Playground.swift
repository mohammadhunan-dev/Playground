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

struct Playground {
    
    static func execute() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(IntObject())
        }
    }
    
}
