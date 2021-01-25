//
//  Playground.swift
//  PlaygroundApp
//
//  Created by Dominic Frei on 22/01/2021.
//

import Foundation
import RealmSwift

//class IntObject: Object {
//    @objc dynamic var id: Int = 0
//}
//
//class IntObject2: Object {
//    let id = RealmOptional<Int>()
//}

struct Playground {
    
    static func execute() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                /// MigrationBlock
                if oldSchemaVersion < 1 {
                    print("Migrating to 1")
                }
                
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: Client.className()) { oldObject, newObject in
                        let id = oldObject!["id"] as? Int
                        newObject!["id"] = id ?? 0
                    }
                }
            })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        try! realm.write {
            realm.add(Client())
            realm.add(Client())
            realm.add(Client())
        }
        //        Realm.performMigration(for: <#T##Realm.Configuration#>)
        
    }
    
}

/// schema version 2
class Client: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
